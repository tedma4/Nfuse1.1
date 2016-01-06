module Biz
	class Post < TimelineEntry
    attr_reader :page
    def self.from(post, provider, page)
      new(post, provider, page)
    end

    def initialize(post, provider, page)
      @post = post
      @provider = provider
      @page = page
    end

    def provider
      @provider
    end

    def avatar
      if @page.twitter_handle == 'blank'
        'wired'
      else
        @page.twitter_handle
      end 
    end

    def username
      @page.thing_name
    end

    def page_link
      @page.page_name
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

    def is_not_retweeted?
      if @post.attrs.has_key? :retweeted_status
      @post.attrs[:user][:screen_name] == @post.attrs[:retweeted_status][:user][:screen_name]
      else
        true
      end
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

    def has_video_url?
      !@post.attrs[:entities][:urls] == []
    end

    def twitter_url_video
      @post.attrs[:entities][:urls][0][:expanded_url].match(/youtube.com.*(?:\/|v=)([^&$]+)/)[1]
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
          if type == "animated_gif"
            @post.attrs[:extended_entities][:media][0][:video_info][:variants][0][:url]
          elsif type == "video"
            @post.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
          end
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