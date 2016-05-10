class PagesController < ApplicationController
  include Poly::Commentable

  before_action :set_page, except:[:home, :help, :about, :feedback, :terms, :index,
                                   :privacy, :business_connector, :celebrity_connector,
                                   :tv_show_connector, :fashion_connector, :youtubers,
                                   :sports_connector, :music_connector, :food_connector,
                                   :travel_connector, :mytop50, :mostpopular,
                                   :random, :trending, :individual_post, :news_connector,
                                   :fitness_connector, :nerdish_connector, :shopping_connector,
                                   :wedding_connector, :animals_connector, :instagramers_connector,#:show#, :wiredtestthing
                                  ]
  before_action :page_from_params, only: :show
  # before_action :find_page, except:[:home, :help, :about, :feedback, :terms,
  #                                  :privacy, :business_connector, :celebrity_connector,
  #                                  :tv_show_connector, :fashion_connector, :youtubers,
  #                                  :sports_connector, :music_connector, :food_connector,
  #                                  :travel_connector, :test_page, :mytop50, :mostpopular,
  #                                  :random, :trending, :wiredtestthing
  #                                 ]
  #Blank is gonna be a reservered word for now
  def index
    pages = Page.find_by_sql("select * from pages limit 50").map { |page| {page: page} }
    if params[:page]
      @pages = get_page_and_offset(13, params[:page].to_i, pages)
    else
      @pages = get_page_and_offset(13, 1, pages)
    end

    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def show
    page     = Biz::Timeline.new(@page).construct(params)
    @timeline = page[:page_feeds].flatten.sort {|a, b| b.created_time <=> a.created_time}

    @page_image = page[:page_image]
  end

  def show_forum
    @page = Page.find_by_page_name(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def page_from_params
    @page = Page.find_by_page_name(params[:id])
  end

  def home
    if signed_in?
      @providers = Providers.for(current_user)
      # @token = []
      # if current_user.followed_users.any?
      #   current_user.followed_users.each do |i|
      #     @token << i.tokens.pluck(:provider, :uid, :access_token, :access_token_secret, :refresh_token)
      #   end
      #   unless @token.empty?
      #     @token = @token[0]
      #   else
      #     @token
      #   end
      # else
      #   @token
      # end
      timeline = []
      ids =  current_user.relationships.where(follow_type: 'User').collect(&:followed_id)
      unless ids.empty?
        @users = User.where(id: ids)
        @users.find_each do |user|
          feed=Networks::Timeline.new(user)
          timeline << feed.construct(params)
          @unauthed_accounts = feed.unauthed_accounts
        end
      end
      @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    end
    # render 'home' is implicit.
  end

  def individual_post
    @post = {
    post_id: params[:post_id],
    provider: params[:provider],
    user: params[:user]
  }
    post_type = params[:post_type]
    if post_type == 'User'
      @user = User.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @user).construct
    else
      @page = Page.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @page).construct
    end
  end

  private
  # def find_page
  #   @page = Page.find_by(page_name: params[:action])
  # end

  def set_page
    impressionist(@page)
    @page.increment!(:view_count)
  end

  public

  def help; end
  # def about; end
  def privacy; end

  def business_connector
    @pages = PageFetcher.new("business").get!
    # @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def celebrity_connector
    @pages = PageFetcher.new("celebrity").get!
  end

  def tv_show_connector
    @pages = PageFetcher.new("tv").get!
  end

  def fashion_connector
    @pages = PageFetcher.new("fashion").get!
  end

  def youtubers
    @pages = PageFetcher.new("youtubers").get!
  end

  def sports_connector
    @pages = PageFetcher.new("sports").get!
  end

  def music_connector
    @pages = PageFetcher.new("music").get!
  end

  def food_connector
    @pages = PageFetcher.new("food").get!
  end

  def travel_connector
    @pages = PageFetcher.new("travel").get!
  end

  def news_connector
    @pages = PageFetcher.new("news").get!
  end

  def fitness_connector
    @pages = PageFetcher.new("fitness").get!
  end

  def nerdish_connector
    @pages = PageFetcher.new("nerdish").get!
  end

  def shopping_connector
    @pages = PageFetcher.new("shopping").get!
  end

  def wedding_connector
    @pages = PageFetcher.new("wedding").get!
  end

  def animals_connector
    @pages = PageFetcher.new("animals").get!
  end

  def instagramers_connector
    @pages = PageFetcher.new("instagrammers").get!
  end

  def mytop50
    @pages = []
    page_ids = []
    seen_pages = Page.joins(:impressions).where("impressions.user_id = ?",current_user.id).group("pages.id")
    non_seen_pages = Page.where("id not in (?)", seen_pages.pluck(:id)).order("view_count desc")
    page_ids << seen_pages
    page_ids << non_seen_pages
    page_ids.flatten.first(50).each do |id|
      page = Page.find(id)
      element = {
        page: page,
        image: page.profile_pic
      }
      @pages << element
    end
    @pages
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def mostpopular
    @pages = Page.order('view_count desc limit 50').map { |page| {page: page, image: page.profile_pic} }
    @pages
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def random
    pages = Page.find_by_sql('select * from pages limit 50').shuffle.map { |page| {page: page, image: page.profile_pic} }
    if params[:page]
      @pages = get_page_and_offset(12, params[:page].to_i, pages)
    else
      @pages = get_page_and_offset(12, 1, pages)
    end
    
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def trending
    pages = Page.joins(:impressions).where("impressions.created_at >= ?", 1.week.ago).group("pages.id").map { |page| {page: page}}
    if params[:page]
      @pages = get_page_and_offset(12, params[:page].to_i, pages)
    else
      @pages = get_page_and_offset(13, 1, pages)
    end
    
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def get_page_and_offset(per_page, page = 1, pages)
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