class PagesController < ApplicationController
  include Poly::Commentable

  before_action :set_page, except:[:home, :help, :about, :feedback, :terms, :index,
                                   :privacy, :business_connector, :celebrity_connector,
                                   :tv_show_connector, :fashion_connector, :youtubers,
                                   :sports_connector, :music_connector, :food_connector,
                                   :travel_connector, :test_page, :mytop50, :mostpopular,
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
    @pages = []
    page_ids = Page.all
    page_ids.each do |insert_page|
      element = {
        page: insert_page,
        image: insert_page.profile_pic
      }
      @pages << element
    end
    @pages
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
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end

  def business_connector
    @pages = PageFetcher.new("business").get!
    # byebug
    @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
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
    @pages = PageFetcher.new("tv").get!
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
    @pages = PageFetcher.new("tv").get!
  end

  # Add The corresponding routes and views for these pages
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
    seen_pages = Page.where(id: Impression.where(user_id: current_user.id, impressionable_type: 'Page').pluck(:impressionable_id).uniq)
    non_seen_pages = Page.where.not(id: Impression.where(user_id: current_user.id, impressionable_type: 'Page').pluck(:impressionable_id).uniq)
    page_ids << seen_pages
    page_ids << non_seen_pages
    page_ids.flatten.each do |id|
      page = Page.find(id)
      element = {
        page: page,
        image: page.profile_pic
      }
      @pages << element
    end
    @pages = Kaminari.paginate_array(@pages).page(1).per(10)
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def mostpopular
    page_ids = Page.order('view_count desc').page(params[:page]).per(10)
    @pages = []
    page_ids.each do |page|
      element = {
        page: page,
        image: page.profile_pic
      }
      @pages << element
    end
    @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  # Pluck all id's
  # m.sort_by {|a, b| -Impression.where(action_name: a.to_s).count}
  #Impressions where

  def random
    @pages = []
    page_ids = Page.first(50).shuffle
    page_ids.each do |insert_page|
      element = {}
      element[:page] = insert_page
      element[:image] = insert_page.profile_pic
      @pages << element
    end
    @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js {render 'paginate_pages.js.erb'}
    end
  end

  def trending
    @pages = []
    page_ids = Page.all.pluck(:id)
      page_ids.sort_by {|a,b| -Impression.where(impressionable_id: a).count}
      page_ids.first(20).each do |id|
        element = {}
        page = Page.find(id)
        element[:page] = page
        element[:image] = page.profile_pic
        @pages << element
      end
     @pages
  end

  # End of Controller
end

# @pages.first do |a, b| puts "#{a[:page].description},   #{b}" end
    # page_stuff = {}
    # page     = Biz::Timeline.new(@page)
    # page_stuff[:feed] = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
    # page_stuff[:profile_picture] = @page.profile_pic
    # @timeline = page_stuff[:feed]
    # @page_image = page_stuff[:profile_picture]