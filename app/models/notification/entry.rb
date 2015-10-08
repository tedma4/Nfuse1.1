module Notification
	class Entry < TimelineEntry

    def self.from(entry, provider)
      new(entry, provider)
    end

    def initialize(entry, provider)
      @entry = entry
      @provider = provider
    end

    def provider
      @provider
    end

    def avatar
      case(@provider)
        when 'twitter'
          @entry.attrs[:user][:profile_image_url]
        when 'youtube'
          "youtubeblue.fw.png"
        when 'instagram'
          @entry["user"]['profile_picture']
      end
    end

    def user_name
      case(@provider)
        when 'twitter'
          @entry.attrs[:user][:screen_name]
        when 'youtube'
          if @entry.channel_title.present?
            @entry.channel_title
          else
            "Youtube User"
          end
        when 'instagram'
          @entry["user"]['username']
      end
    end

    #-----------id----------

    def id
      case(@provider)
        when 'twitter'
          @entry.id
        when 'youtube'
          @entry.id
        when 'instagram'
          @entry["id"]
        when 'facebook'
          @entry["id"]
      end
    end

    #-----------type----------

    def has_media?
      @entry.attrs.has_key? :extended_entities
    end

    def type
      case(@provider)
        when 'twitter'
          @entry.attrs[:extended_entities][:media][0][:type]
        when 'instagram'
          @entry["type"]
        when 'facebook'
          @entry["type"]
      end
    end
    #-----------text----------

    def text
      case(@provider)
        when 'twitter'
          @entry.text
        when 'youtube'
          @entry.description
        when 'instagram'
          if @entry['caption'].present?
            @entry['caption']['text']
          end
        when 'facebook'
          @entry['caption']
      end
    end

    #-----------image----------

    def image
      case(@provider)
        when 'twitter'
          @entry.attrs[:extended_entities][:media][0][:media_url]
        when 'instagram'
          @entry["images"]["low_resolution"]["url"]
        when 'facebook'
          @entry['picture']
      end
    end

    #-----------video----------

    def video
      case(@provider)
        when 'twitter'
          if type == "animated_gif"
            @entry.attrs[:extended_entities][:media][0][:video_info][:variants][0][:url]
          elsif type == "video"
            @entry.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
          end
        when 'youtube'
          @entry.id
        when 'instagram'
          @entry["videos"]["standard_resolution"]["url"]
        when 'facebook'
          @entry['source'].sub("?autoplay=1", "")
      end
    end

    #-----------created_at----------
    def created_time
      case(@provider)
        when 'twitter'
          @entry.created_at
        when 'youtube'
          @entry.published_at
        when 'instagram'
          Time.at(@entry['created_time'].to_i)
        when 'facebook'
          @entry['created_time']
      end
    end

    #-----------other----------

    def link_to_entry
      case(@provider)
        when 'twitter'
          "https://twitter.com/#{user_name}/status/#{id}"
        when 'youtube'
          "https://www.youtube.com/watch?v=#{@entry.id}"
        when 'instagram'
          @entry["link"]
        when 'facebook'
          @entry['actions'][0]['link']
      end
    end

    def description
      @entry['description']
    end

    def name
      @entry['name']
    end

    def message
      @entry['message']
    end

    def source
      @entry['source']
    end

    def likes #favorites
      case(@provider)
        when 'twitter'
          @entry.favorite_count
        when 'instagram'
          @entry['likes']['count']
        when 'youtube'
          'find view count'
      end
    end
  end
end