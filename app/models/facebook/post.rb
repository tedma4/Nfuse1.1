module Facebook
  class Post < TimelineEntry

  attr_reader :user

    def self.from(post, user=current_user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).size
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:small)
    end

    def username
      @user.user_name
    end

    def link_to_post
      begin
        @post['link']
      rescue
        @post['actions'][0]['link']
      end
    end

    def created_time
      @post['created_time']
    end

    def provider
      "facebook"
    end

    def id
      @post['id']
    end

    def source
      @post['source']
    end

    def youtube_source
      @post['source'].sub("?autoplay=1", "")
    end

    def post_user
      @post.user
    end

    def article_link
      @post['link']
    end

    def type
      @post['type']
    end

    def status_type
      @post['status_type']
    end

    def story
      @post['story']
    end
  
    def image
      if type == 'photo'
        @token = @user.tokens.find_by(provider: 'facebook')
        @graph = Koala::Facebook::API.new @token.access_token
        begin
          @post = @graph.get_object(@post['object_id'])
          @post['images'][0]['source']
        rescue
          @post['picture']
        end
      else
        @post['picture']
      end
    end

    def description
       @post['description']
    end

    def message
      @post['message']
    end

    def name
      @post['name']
    end

    def text
      @post['caption']
    end
  end
end