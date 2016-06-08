class SearchesController < ApplicationController

  def searchcontent
	  @search = params[:search]
    case params[:selected_option]
    when "Nfusers"
      if @search
        if @search == ''
          @users = User.where.not(id: current_user.id).order('id desc')
        else
          @users = User.search(@search).order("created_at DESC")
        end
      else
        @users = User.all.order('created_at DESC')
      end
    when "Pages"
      if @search
        if search == ''
          @pages = Page.first(25)
        else
          @pages = Page.search(@search).order("id DESC")
        end
      else
        @pages = Pages.first(25)
      end
    when "Posts", ""
      unless @search.empty?
        page     = Search::Timeline.new(@search)
        @timeline = page.construct(params)
      else
        @timeline = nil
      end
    end
	end
  def random_search
    getbeginning = ['@', '#', '']
    choosefromlist = Page.pluck(:page_name)
    @searched = getbeginning.shuffle.first + choosefromlist.shuffle.first
    page     = Search::Timeline.new(@searched)
    @timeline = page.construct(params)
  end
end