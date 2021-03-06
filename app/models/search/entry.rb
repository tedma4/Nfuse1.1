module Search
	class Entry < TimelineEntry
  attr_reader :post

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
          "YouTube.jpg"
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
      @post.attrs.has_key?(:extended_entities) || @post.attrs.has_key?(:entities)
    end

    def type
      case(@provider)
        when 'twitter'
          if @post.attrs.has_key? :extended_entities
            @post.attrs[:extended_entities][:media][0][:type]
          elsif @post.attrs.has_key? :entities
            if !@post.attrs[:entities][:urls].empty?
              if @post.attrs[:entities][:urls][0][:expanded_url].include?('youtube')
              'youtube_video'
              else
                return false
              end
            elsif @post.attrs[:entities].has_key? :media
              @post.attrs[:entities][:media][0][:type]
            else
              return false
            end
          else
            return false
          end
        when 'instagram'
          @post['type']
        when 'facebook'
          @post["type"]
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