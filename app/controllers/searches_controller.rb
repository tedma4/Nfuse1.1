class SearchesController < ApplicationController
	#This controls the searches
  def index
  	#This shows all the users that fit the search criteria
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end	

  def searchcontent
	  @search = params[:search]
    case params[:selected_option]
    when "Nfusers"
      if @search
        @users = User.search(@search).order("created_at DESC")
      else
        @users = User.all.order('created_at DESC')
      end
    when "Pages"
      if @search
        @pages = Page.search(@search).order("id DESC")
      else
        @pages = Pages.all.order('id DESC')
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