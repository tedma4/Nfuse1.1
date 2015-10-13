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
        when 'vimeo'
          @entry.embedUrl
      end
    end

    #-----------type----------

    def has_media?
      @entry.has_key? :extended_entities
    end

    def type
      case(@provider)
        when 'twitter'
          @entry[:extended_entities][:media][0][:type]
        when 'instagram'
          @entry["type"]
        when 'facebook'
          @entry["type"]
        when 'tumblr'
          @entry["type"]
      end
    end
    #-----------text----------

    def text
      case(@provider)
        when 'twitter'
          @entry[:text]
        when 'youtube'
          @entry.description
        when 'instagram'
          if @entry['caption'].present?
            @entry['caption']['text']
          end
        when 'facebook'
          @entry['caption']
        when 'tumblr'
          if @entry['type'] == 'quote'
            @entry['text']
          else
            @entry['caption']
          end
        when 'vimeo'
          @entry.description
      end
    end

    #-----------image----------

    def image
      case(@provider)
        when 'twitter'
          @entry[:extended_entities][:media][0][:media_url]
        when 'instagram'
          @entry["images"]["low_resolution"]["url"]
        when 'facebook'
          if type == 'photo'
            @token = @user.tokens.find_by(provider: 'facebook')
            @graph = Koala::Facebook::API.new @token.access_token
            begin
              @entry = @graph.get_object(@entry['object_id'])
              @entry['images'][0]['source']
            rescue
              @entry['picture']
            end
          else
            @entry['picture']
          end
        when 'tumblr'
      @entry['photos'][0]['alt_sizes'][0]['url']          
      end
    end

    #-----------video----------

    def video
      case(@provider)
        when 'twitter'
          if type == "animated_gif"
            @entry[:extended_entities][:media][0][:video_info][:variants][0][:url]
          elsif type == "video"
            @entry[:extended_entities][:media][0][:video_info][:variants][2][:url]
          end
        when 'youtube'
          @entry.id
        when 'instagram'
          @entry["videos"]["standard_resolution"]["url"]
        when 'facebook'
          @entry['source'].sub("?autoplay=1", "")
        when 'tumblr'
          @entry['player'][0]['embed_code'].match(/src="(.*)\?/)[1]
      end
    end

    def has_video_url?
      !@entry[:entities][:urls] == []
    end

    def twitter_url_video
      @entry[:entities][:urls][0][:expanded_url].match(/youtube.com.*(?:\/|v=)([^&$]+)/)[1]
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

    def body
      @entry['body'].html_safe
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

    def youtube_source
      @entry['source'].sub("?autoplay=1", "")
    end

    def description
      @entry['description'].html_safe
    end
    def excerpt
      @entry['excerpt']
    end

    #-----------------Nfuse--------------


    def content
      @entry.content
    end

    def link?
      @entry.link
    end

    def link
      @entry.link
    end

    def is_link?
      @entry.is_link
    end

    def is_link
      @entry.is_link
    end

    def uid
      @entry.uid
    end

    def title
      @entry.title
    end

    def author
      @entry.author
    end

    def duration
      @entry.duration
    end

    def is_pic?
      @entry.is_pic
    end

    def pic_url
      @entry.pic.url(:medium)
    end

    def is_video?
      @entry.is_video
    end

    def video_url
      @entry.snip.url(:medium)
    end

    def is_full_video?
      @entry.is_full_video
    end

    def full_video_url
      @entry.video.url(:medium)
    end

    def url_html
      @entry.url_html
    end

    def url
      @entry.url
    end

    def has_content?
      @entry.has_content
    end

    def has_content
      @entry.has_content
    end


  end
end
