require_relative 'api'

module Facebook
  class Post < TimelineEntry

  attr_reader :user  
  
  include Api

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def link_to_post
      @post['actions'][0]['link']
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
  
    def image
      @post['picture']
    end

    def description
       @post['description']
    end

    def message
      @post['message']
    end

    def caption
      @post['caption']
    end
  end
end