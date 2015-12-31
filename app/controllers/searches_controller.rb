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
    begin
	  @search = params[:search]
	  page     = Search::Timeline.new(@search)
	  @timeline = page.construct(params)
    rescue
    end
	end
end