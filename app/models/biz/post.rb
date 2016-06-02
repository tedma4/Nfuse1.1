module Biz
	class Post < TimelineEntry
    attr_reader :page, :provider
    def self.from(post, provider, page)
      new(post, provider, page)
    end

    def initialize(post, provider, page)
      @post = post
      @provider = provider
      @page = page
    end
    
    def avatar
      if @page.twitter_handle == 'blank'
        'wired'
      else
        # @post['user']['profile_picture']
        'wired'
      end 
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).size
    end

    def username
      @page.full_name
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
        when 'google_oauth2'
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
      @post.attrs.has_key?(:extended_entities) || @post.attrs.has_key?(:entities)
    end
    def type
      case(@provider)
        when 'instagram'
          @post["type"]
        when 'twitter'
          if @post.attrs.has_key? :extended_entities
            @post.attrs[:extended_entities][:media][0][:type]
          elsif @post.attrs.has_key? :entities
            if @post.attrs[:entities].has_key? :media
              @post.attrs[:entities][:media][0][:type]
            else
              return false
            end
          else
            return false
          end
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
        begin
        if @post.attrs.has_key? :extended_entities
          @post.attrs[:extended_entities][:media][0][:media_url]
        elsif @post.attrs.has_key? :entities
          if @post.attrs[:entities].has_key? :media
            if @post.attrs[:entities][:media].is_a? Array
              if @post.attrs[:entities][:media][0].has_key? :media_url
                @post.attrs[:entities][:media][0][:media_url]
              else
                return false
              end
            else
              return false
            end
          else
            return false
          end
        else
          return false
        end
        rescue
          return false
        end
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
        when 'google_oauth2'
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
        when 'google_oauth2'
          @post.published_at
      end
    end

    #-----------other----------

	end
end