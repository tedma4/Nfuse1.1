module Tumblr
  class Posting < TimelineEntry

  attr_reader :user

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    # 
    def like_score(id)
      # Implement counter cache per / Records
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def created_time
      @post['date']
    end

    def provider
      "tumblr"
    end

    def id
      @post['id']
    end

    def link_to_post
      @post['post_url']
    end

    def caption_text
      @post['caption'].html_safe
    end

    def photo
      @post['photos'][0]['alt_sizes'][0]['url']
    end

    def video
      if @post['video_type'] == 'tumblr'
        @post['video_url']
      else
        @post['player'][0]['embed_code'].match(/src="(.*)\?/)[1]
      end
    end

    def video_thumbnail
      @post['thumbnail_url']
    end

    def video_type
      @post['video_type']
    end

    def audio
      @post['player']
    end

    def type
      @post['type']
    end

    def body
      @post['body'].html_safe
    end

    def text
      @post['text'].html_safe
    end

    def link_to_url
      @post['url']
    end

    def description
      @post['description'].html_safe
    end
    def excerpt
      @post['excerpt']
    end
  end
end