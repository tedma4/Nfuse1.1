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

    def id
      @post.id
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def link_to_post
      "https://facebook.com/#{username}/status/#{id}"
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

    def post_user
      @post.user
    end

  def story
    @post['story']
  end

  def story_tags
    @post['story_tags']#.map { |story_tag| StoryTag.from(story_tag) }
  end

  def caption_text
    @post['caption']
  end

  def article_link
    @post['link']
  end

    def post_video
      @post.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
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
  end
end