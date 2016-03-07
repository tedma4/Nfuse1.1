require 'active_support/concern'

module Poly::Commentable
  extend ActiveSupport::Concern

  included do
    before_action :comments, :only => [:show]
  end

  def comments
    @commentable = find_commentable
    @comments = @commentable.comments.arrange(:order => :created_at)
    @comment = Comment.new
  end

  private

  def find_commentable
    if params[:controller] == 'pages'
      @page = Page.find_by_page_name(params[:id])
      # byebug
      return params[:controller].singularize.classify.constantize.find(@page.id)
    else
      return params[:controller].singularize.classify.constantize.find(params[:id])
    end
  end
end