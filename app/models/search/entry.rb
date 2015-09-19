module Search
	class Entry < TimelineEntry

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

    def avatar
      case(@provider)
        when 'twitter'
          @post.attrs[:user][:profile_image_url]
        when 'youtube'
          "youtubeblue.fw.png"
        when 'instagram'
          @post["user"]['profile_picture']
      end
    end

    def user_name
      case(@provider)
        when 'twitter'
          @post.attrs[:user][:screen_name]
        when 'youtube'
          if @post.channel_title.present?
            @post.channel_title
          else
            "Youtube User"
          end
        when 'instagram'
          @post["user"]['username']
      end
    end

    #-----------id----------

    def id
      case(@provider)
        when 'twitter'
          @post.id
        when 'youtube'
          @post.id
        when 'instagram'
          @post["id"]
        when 'facebook'
          @post["id"]
      end
    end

    #-----------type----------

    def has_media?
      @post.attrs.has_key? :extended_entities
    end
    
    def type
      case(@provider)
        when 'twitter'
          @post.attrs[:extended_entities][:media][0][:type]
        when 'instagram'
          @post["type"]
        when 'facebook'
          @post["type"]
      end
    end
    #-----------text----------

    def text
      case(@provider)
        when 'twitter'
          @post.text
        when 'youtube'
          @post.description
        when 'instagram'
          if @post['caption'].present?
            @post['caption']['text']
          end
        when 'facebook'
          @post['caption']
    	end
    end

    #-----------image----------

    def image
      case(@provider)
        when 'twitter'
          @post.attrs[:extended_entities][:media][0][:media_url]
        when 'instagram'
          @post["images"]["low_resolution"]["url"]
        when 'facebook'
          @post['picture']
      end
    end

    #-----------video----------

    def video
      case(@provider)
        when 'twitter'
          if type == "animated_gif"
            @post.attrs[:extended_entities][:media][0][:video_info][:variants][0][:url]
          elsif type == "video"
            @post.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
          end
        when 'youtube'
          @post.id
        when 'instagram'
          @post["videos"]["standard_resolution"]["url"]
        when 'facebook'
          @post['source'].sub("?autoplay=1", "")
      end	      	
    end

    #-----------created_at----------
    def created_time
      case(@provider)
        when 'twitter'
          @post.created_at
        when 'youtube'
          @post.published_at
        when 'instagram'
          Time.at(@post['created_time'].to_i)
        when 'facebook'
          @post['created_time']
      end
    end

    #-----------other----------

    def link_to_post
      case(@provider)
        when 'twitter'
          "https://twitter.com/#{user_name}/status/#{id}"
        when 'youtube'
          "https://www.youtube.com/watch?v=#{@post.id}"
        when 'instagram'
          @post["link"]
        when 'facebook'
          @post['actions'][0]['link']
      end
    end

    def description
       @post['description']
    end

    def name
      @post['name']
    end

    def message
      @post['message']
    end

    def source
      @post['source']
    end

    def likes #favorites
      case(@provider)
        when 'twitter'
          @post.favorite_count
        when 'instagram'
          @post['likes']['count']
        when 'youtube'
          'find view count'
      end
    end
	end
end