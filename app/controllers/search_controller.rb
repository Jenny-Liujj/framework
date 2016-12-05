class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @posts = []
    else
      # @posts = Post.search params[:q]
      @posts = Post.search_by_title_or_content params[:q]
    end
  end
end
