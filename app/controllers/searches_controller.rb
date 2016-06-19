class SearchesController < ApplicationController

  def searchcontent
	  @search = params[:search]
    case params[:selected_option]
    when "Nfusers"
      if @search
        if @search == ''
          users = User.where.not(id: current_user.id).order('id desc')
          if params[:page]
            @users = paginate_search_results(1, params[:page].to_i, users)
          else
            @users = paginate_search_results(1, 1, users)
          end
        else
          users = User.search(@search).order("created_at DESC")
          if params[:page]
            @users = paginate_search_results(1, params[:page].to_i, users)
          else
            @users = paginate_search_results(1, 1, users)
          end
        end
      else
        users = User.all.order('created_at DESC')
        if params[:page]
          @users = paginate_search_results(1, params[:page].to_i, users)
        else
          @users = paginate_search_results(1, 1, users)
        end
      end

    respond_to do |format|
      format.html
      format.js {render 'paginate_search.js.erb'}
    end
    when "Pages"
      if @search
        if @search == ''
          pages = Page.first(25)
          if params[:page]
            @pages = paginate_search_results(1, params[:page].to_i, pages)
          else
            @pages = paginate_search_results(1, 1, pages)
          end
        else
          pages = Page.search(@search).order("id DESC")
          if params[:page]
            @pages = paginate_search_results(1, params[:page].to_i, pages)
          else
            @pages = paginate_search_results(1, 1, pages)
          end
        end
      else
        pages = Pages.first(25)
        if params[:page]
          @pages = paginate_search_results(1, params[:page].to_i, pages)
        else
          @pages = paginate_search_results(1, 1, pages)
        end
      end

    respond_to do |format|
      format.html
      format.js {render 'paginate_search.js.erb'}
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

  def paginate_search_results(per_page, page = 1, pages)
    total = pages.length
    if total > 0
      if per_page >= total # 10 or 11
        result = pages.first(total)
        params[:last_page] = page
        return result
      elsif per_page < total # 23

        if ( page * per_page ) < total # 2 * 11 < 23
          if page == 1
            result = pages[0..(per_page - 1)]
            params[:first_page] = page
            return result
          else
            offset_by = ( page - 1 ) * per_page # 1 * 11
            next_page = (page * per_page) - 1
            result = pages[offset_by..next_page]
            params[:middle_page] = page
            return result
          end
        elsif ( page * per_page ) >= total # 3 * 11 > 23
          offset_by = ( page - 1 ) * per_page
          to_end = total - 1
          result = pages[offset_by..to_end]
          params[:last_page] = page
          return result
        else
          # Noting more to do
        end

      else
        # Nothing more to do
      end
    else
      # Do Nothing
    end
  end
end