class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection

  def collect
    if @collection.value == 0 and not @collection.is_abused?
      @collection.update_attribute :value, 1
      @collection.collectable.update_attribute :collection_count, @collection.collectable.collection_count+1 if @collection.value == 1
    end
  end

  def uncollect
    if @collection.value == 1 and not @collection.is_abused?
      @collection.update_attribute :value, 0
      @collection.collectable.update_attribute :collection_count, @collection.collectable.collection_count-1 if @collection.value == 0
    end
  end

  private

  def set_collection
    args = { collectable_type: params[:collectable_type], collectable_id: params[:collectable_id] }
    @collection = current_user.collections.find_or_create_by args
  end
end
