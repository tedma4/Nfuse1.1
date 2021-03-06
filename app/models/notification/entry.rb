module Notification
	class Entry < TimelineEntry
    attr_reader :user, :provider, :entry
    def self.from(entry, provider, user)
      new(entry, provider, user)
    end

    def initialize(entry, provider, user)
      @entry = entry
      @provider = provider
      @user = user
    end
    #-----------id----------

    def id
      case(@provider)
        when 'twitter'
          @entry[:id]
        when 'google_oauth2'
          @entry.id
        when 'instagram'
          @entry["id"]
        when 'facebook'
          @entry["id"]
        when 'vimeo'
          @entry.embedUrl
        when 'gplus'
          @entry.id
        when 'pinterest'
          @entry['id']
        when 'tumblr'
          @entry['id']
        else
          @entry.id
      end
    end

    #-----------type----------

    def has_media?
      @entry.has_key? :extended_entities
    end

    def type
      case(@provider)
        when 'twitter'
          if @entry.has_key? :extended_entities
            @entry[:extended_entities][:media][0][:type]
          elsif @entry.has_key? :entities
            if !@entry[:entities][:urls].empty?
              if @entry[:entities][:urls][0][:expanded_url].include?('youtube')
              'youtube_video'
              else
                return false
              end
            elsif @entry[:entities].has_key? :media
              @entry[:entities][:media][0][:type]
            else
              return false
            end
          else
            return false
          end
        when 'instagram'
          @entry["type"]
        when 'facebook'
          @entry["type"]
        when 'tumblr'
          @entry["type"]
        when 'gplus'
          if @entry.object.attributes.include? 'attachments'
            if @entry.object.attachments[0]['objectType'] == 'video'
              if @entry.object.attachments[0].has_key? "embed"
                'video'
              else
                'hiddenType'
              end
            else
              @entry.object.attachments[0]['objectType']
            end
          else
            case @entry.object.object_type
              when 'note'
                'hiddenType'
              else
                @entry.object.object_type
            end
          end
        when 'pinterest'
          @entry['media']['type']  
        end
      end
    #-----------text----------

    def text
      case(@provider)
        when 'twitter'
          @entry[:text]
        when 'google_oauth2'
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
          elsif @entry['type'] == 'link'
            @entry['description']
          else
            @entry['caption']
          end
        when 'vimeo'
          @entry.description
        when 'pinterest'
          @entry['note']
        when 'gplus'
          @entry.object.content
      end
    end

    #-----------image----------

    def image
      case(@provider)
        when 'twitter'
          begin
          if @entry.has_key? :extended_entities
            @entry[:extended_entities][:media][0][:media_url]
          elsif @entry.has_key? :entities
            if @entry[:entities].has_key? :media
              if @entry[:entities][:media].is_a? Array
                if @entry[:entities][:media][0].has_key? :media_url
                  @entry[:entities][:media][0][:media_url]
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
          @entry["images"]["low_resolution"]["url"]
        when 'facebook'
          if @entry['type'] == 'photo'
            @fb_token = @user.tokens.find_by(provider: 'facebook')
            @graph = Koala::Facebook::API.new @fb_token.access_token
            begin
              @entry = @graph.get_object(@entry['object_id'])
              @entry['images'][0]['source']
            rescue
              @entry['picture']
            end
          else
            @entry['picture']
          end
          # if @entry['type'] == nil
          #   begin
          #     @entry['images'][0]['source']
          #   rescue
          #     @entry['picture']
          #   end
          # else
          #   @entry['picture']
          # end
        when 'tumblr'
          @entry['photos'][0]['alt_sizes'][0]['url']
        when 'gplus'
          @entry.object.attachments[0]["image"]["url"]
        when 'pinterest'
          @entry['image']['original']['url']
      end
    end

    def fb_image
      begin
        @entry['images'][0]['source']
      rescue
        @entry['picture']
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
        when 'google_oauth2'
          @entry.id
        when 'instagram'
          @entry["videos"]["standard_resolution"]["url"]
        when 'facebook'
          if @entry['source'].include?('?autoplay=1')
            @entry['source'].sub!("?autoplay=1", "")
          else
            @entry['source'].sub!("autoplay=1", "")
          end
        when 'tumblr'
          if @entry['video_type'] == 'tumblr'
            @entry['video_url']
          else
            @entry['player'][0]['embed_code'].match(/src="(.*)\?/)[1]
          end
        when 'pinterest'
          if @entry['attribution']['url'].include?('youtube')
            @entry['attribution']['url'].gsub('watch?v=', 'embed/')
          else
            @entry['attribution']['url']
          end
        when 'gplus'
          if @entry.object.attachments[0].has_key? "embed"
            @entry.object.attachments[0]["embed"]["url"]
          else
            @entry.object.attachments[0]["image"]["url"]
          end
      end
    end

    def video_thumbnail
      @entry['thumbnail_url']
    end

    def video_type
      @entry['video_type']
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
          @entry[:created_at]
        when 'google_oauth2'
          @entry.published_at
        when 'instagram'
          Time.at(@entry['created_time'].to_i)
        when 'facebook'
          @entry['created_time']
        when 'pinterest'
          @entry['created_at']
        when 'tumblr'
          @entry['date']
        when 'gplus'
          @entry.attributes['published']
        when 'vimeo'
          @entry.created_time
        else
          @entry.created_at
      end
    end

    def body
      @entry['body'].html_safe
    end

    #-----------other----------

    def link_to_entry
      case(@provider)
        when 'twitter'
          "https://twitter.com/#{@entry[:user][:screen_name]}/status/#{@entry['id']}"
        when 'google_oauth2'
          "https://www.youtube.com/watch?v=#{@entry.id}"
        when 'instagram'
          @entry["link"]
        when 'facebook'
          begin
            @entry['link']
          rescue
            @entry['actions'][0]['link']
          end
        when 'pinterest'
          begin
            @entry['url']
          rescue
            @entry['link']
          end
        when 'tumblr'
          begin
            @entry['short_url']
          rescue
            @entry['post_url']
          end
        when 'gplus'
          @entry.attributes['url']
        when 'vimeo'
          @entry.link 
      end
    end

    alias_method :link_to_post, :link_to_entry
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
      if @entry['source'].include?('?autoplay=1')
        @entry['source'].sub!("?autoplay=1", "")
      else
        @entry['source'].sub!("autoplay=1", "")
      end
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
