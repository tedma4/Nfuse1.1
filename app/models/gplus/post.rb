module Gplus
	class Post < TimelineEntry

  attr_reader :user

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).size
    end

    def avatar
      @user.avatar(:small)
    end

    def username
      @user.user_name
    end

    def provider
      "gplus"
    end

    def created_time
      @post.published
    end

    def id
      @post.id
    end

    
    # def video_id
    #   @post.id
    # end

    #TODO gplus api has no easy way to get video author username

    def full_name
        @post.actor.display_name
    end

    def text
      @post.object.content
    end

    def link_to_post
      @post.object.url
    end

    def image
      @post.object.attachments[0]["image"]["url"]
    end

    def video
      if @post.object.attachments[0].has_key? "embed"
        @post.object.attachments[0]["embed"]["url"]
      else
        @post.object.attachments[0]["image"]["url"]
      end
    end

    def type
      if @post.object.attributes.include? 'attachments'
        if @post.object.attachments[0]['objectType'] == 'video'
          if @post.object.attachments[0].has_key? "embed"
            'video'
          else
            'hiddenType'
          end
        else
          @post.object.attachments[0]['objectType']
        end
      else
        case @post.object.object_type
          when 'note'
            'hiddenType'
          else
            @post.object.object_type
        end
      end
      # begin
      #   @post.object.attachments[0]['objectType']
      # rescue
      #   @post.object.object_type
      # end
    end
  end
end