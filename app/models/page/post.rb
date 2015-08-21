module Page
	class Post < TimelineEntry

    def self.from(post, provider)
      new(post, provider)
    end

    def initialize(post, provider)
      @post = post
      @provider = provider
    end

    def provider
      @provider
    end

    # def avatar
    #   case(@provider)
    #     when 'instagram'
    #       @post["user"]['profile_picture']
    #     when 'twitter'
    #       @post.attrs[:user][:profile_image_url]
    #     when 'youtube'
    #       "youtubeblue.fw.png"
    #   end

    # end

    def username
      case(@provider)
        when 'instagram'
          @post["user"]['username']
        when 'twitter'
          @post.attrs[:user][:screen_name]
        when 'youtube'
          'youtube user'
      end

    end

    #-----------id----------

    def id
      case(@provider)
        when 'instagram'
          @post["id"]
        when 'twitter'
          @post.id
        when 'youtube'
          @post.id
      end
    end

    def is_not_in_reply
      @post.attrs[:in_reply_to_status_id]
    end

    #-----------type----------

    def has_media?
      @post.attrs.has_key? :extended_entities
    end
    def type
      case(@provider)
        when 'instagram'
          @post["type"]
        when 'twitter'
          @post.attrs[:extended_entities][:media][0][:type]
      end
    end
    #-----------text----------

    def text
      case(@provider)
        when 'instagram'
          if @post['caption'].present?
          @post['caption']['text']
          end
        when 'twitter'
          @post.text
        else
          @post.description
    	end
    end

    #-----------image----------

    def image
      case(@provider)
        when 'instagram'
          @post["images"]["low_resolution"]["url"]
        when 'twitter'
          @post.attrs[:extended_entities][:media][0][:media_url]
      end
    end

    #-----------video----------

    def video
      case(@provider)
        when 'instagram'
          @post["videos"]["standard_resolution"]["url"]
        when 'twitter'
          @post.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
        else
      	@post.id
      end	      	
    end

    #-----------link----------

    def link_to_post
      case(@provider)
        when 'instagram'
          @post["link"]
        when 'twitter'
          "https://twitter.com/#{username}/status/#{id}"
        when 'youtube'
          "https://www.youtube.com/watch?v=#{@post.id}"
    	end
    end

    #-----------created_at----------
    def created_time
      case(@provider)
        when 'instagram'
          Time.at(@post['created_time'].to_i)
        when 'twitter'
          @post.created_at
        when 'youtube'
          @post.published_at
      end
    end

    #-----------other----------

	end
end
