class DashboardController < ApplicationController
  layout 'dashboard'

  AdminModels = %w[users posts comments].freeze

  AdminModelPermittedParams = {
    user: [:email, :role]
  }.freeze

  AdminModels.each do |category|
    model = category.singularize
    model_class = model.classify.constantize
    self.class_eval <<-EOT
      def admin_#{category}
        authorize :dashboard, :show_#{category}?
        @category = '#{category}'
        @search = #{model_class}.search(params[:q])
        @#{category} = @search.result.order(:id).page(params[:page])
        # Record the search and pagination parameters.
        session[:q] = params[:q]
        session[:page] = params[:page]
      end

      def admin_edit_#{model}
        authorize :dashboard, :edit_#{category}?
        @category = '#{category}'
        @#{model} = #{model_class}.find(params[:id])
      end

      def admin_update_#{model}
        authorize :dashboard, :update_#{category}?
        @#{model} = #{model_class}.find(params[:id])
        respond_to do |format|
          if @#{model}.update(params.require(:#{model}).permit(#{AdminModelPermittedParams[model.to_sym]}))
            format.html { redirect_to admin_#{category}_path(page: session[:page], q: session[:q]) }
          else
            format.html { render :admin_edit_#{model} }
          end
        end
      end

      def search_#{category}
        admin_#{category}
        render :admin_#{category}
      end
    EOT
  end
end
