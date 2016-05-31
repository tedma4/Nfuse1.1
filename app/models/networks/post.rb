module Networks
  class Post < TimelineEntry
    attr_reader :user, :post
    def self.from(post, provider, user)
      new(post, provider, user)
    end

    def initialize(post, provider, user)
      @post = post
      @provider = provider
      @user = user
    end

    def provider
      @provider
    end

    def avatar
      if @user.avatar_file_name.present? && @user.avatar_file_name.include?('graph.facebook.com')
        @user.avatar_file_name
      else
        @user.avatar(:small)
      end 
    end

    def username
      @user.user_name
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).size
    end

    #-----------id----------

    def id
      case(@provider)
        when 'twitter'
          @post.id
        when 'google_oauth2'
          @post.id
        when 'instagram'
          @post["id"]
        when 'facebook'
          @post["id"]
        when 'vimeo'
          @post.id
        when 'pinterest'
          @post['id']
        when 'tumblr'
          @post['id']
        when 'gplus'
          @post.id
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
        when 'tumblr'
          @post["type"]
        when 'gplus'
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
            # case @post.object.object_type
            #   when 'note'
            #     'hiddenType'
            #   else
                @post.object.object_type
            # end
          end
        when 'pinterest'
          @post['media']['type']  
        end
      end
    #-----------text----------

    def text
      case(@provider)
        when 'twitter'
          @post[:text]
        when 'google_oauth2'
          @post.description
        when 'instagram'
          if @post['caption'].present?
            @post['caption']['text']
          end
        when 'facebook'
          @post['caption']
        when 'tumblr'
          if @post['type'] == 'quote'
            @post['text']
          elsif @post['type'] == 'link'
            @post['description']
          else
            @post['caption']
          end
        when 'vimeo'
          @post.description
        when 'pinterest'
          @post['note']
        when 'gplus'
          @post.object.content
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
          if @post['type'] == 'photo'
            @fb_token = @user.tokens.find_by(provider: 'facebook')
            @graph = Koala::Facebook::API.new @fb_token.access_token
            begin
              @post = @graph.get_object(@post['object_id'])
              @post['images'][0]['source']
            rescue
              @post['picture']
            end
          else
            @post['picture']
          end
        when 'tumblr'
          @post['photos'][0]['alt_sizes'][0]['url']
        when 'pinterest'
          @post['image']['original']['url']
        when 'gplus'
          @post.object.attachments[0]["image"]["url"]
      end
    end

    def fb_image
      begin
        @post['images'][0]['source']
      rescue
        @post['picture']
      end
    end

    def story
      @post['story']
    end

    def retweeted
      @post.retweeted
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
        when 'google_oauth2'
          @post.id
        when 'instagram'
          @post["videos"]["standard_resolution"]["url"]
        when 'facebook'
          if @post['source'].include?('?autoplay=1')
            @post['source'].sub!("?autoplay=1", "")
          else
            @post['source'].sub!("autoplay=1", "")
          end
        when 'tumblr'
          if @post['video_type'] == 'tumblr'
            @post['video_url']
          else
            @post['player'][0]['embed_code'].match(/src="(.*)\?/)[1]
          end
        when 'gplus'
          if @post.object.attachments[0].has_key? "embed"
            @post.object.attachments[0]["embed"]["url"]
          else
            @post.object.attachments[0]["image"]["url"]
          end
        when 'pinterest'
          @post['attribution']['url']
      end
    end

    def provider_name
      #this is pinterest specific. Might need it for videos that aren't vimeo or youtube
      @post['attribution']['provider_name']
    end

    def video_thumbnail
      @post['thumbnail_url']
    end

    def video_type
      @post['video_type']
    end

    def has_video_url?
      !@post.attrs[:entities][:urls] == []
    end

    def twitter_url_video
      @post.attrs[:entities][:urls][0][:expanded_url].match(/youtube.com.*(?:\/|v=)([^&$]+)/)[1]
    end

    def embedurl
      @post.embedUrl
    end

    #-----------created_at----------
    def created_time
      case(@provider)
        when 'twitter'
          @post.created_at
        when 'google_oauth2'
          @post.published_at
        when 'instagram'
          Time.at(@post['created_time'].to_i)
        when 'facebook'
          @post['created_time']
        when 'gplus'
          @post.attributes['published']
        when 'tumblr'
          @post['date']
        when 'vimeo'
          @post.created_time
        when 'pinterest'
          @post['created_at']
      end
    end

    def body
      @post['body'].html_safe
    end

    #-----------other----------

    def link_to_post
      case(@provider)
        when 'twitter'
          "https://twitter.com/#{@post.attrs[:user][:screen_name]}/status/#{id}"
        when 'google_oauth2'
          "https://www.youtube.com/watch?v=#{@post.id}"
        when 'instagram'
          @post["link"]
        when 'facebook'
          begin
            @post['actions'][0]['link']
          rescue
            @post['link']
          end
        when 'pinterest'
          @post['link']
        when 'tumblr'
          @post['short_url']
        when 'gplus'
          @post.attributes['url']
        when 'vimeo'
          @post.link
      end
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

    def youtube_source
      if @post['source'].include?('?autoplay=1')
        @post['source'].sub!("?autoplay=1", "")
      else
        @post['source'].sub!("autoplay=1", "")
      end
    end

    def description
      @post['description']
    end
    def excerpt
      @post['excerpt']
    end

    #-----------------Nfuse--------------


    def content
      @post.content
    end

    def link?
      @post.link
    end

    def link
      @post.link
    end

    def is_link?
      @post.is_link
    end

    def is_link
      @post.is_link
    end

    def uid
      @post.uid
    end

    def title
      @post.title
    end

    def author
      @post.author
    end

    def duration
      @post.duration
    end

    def is_pic?
      @post.is_pic
    end

    def pic_url
      @post.pic.url(:medium)
    end

    def is_video?
      @post.is_video
    end

    def video_url
      @post.snip.url(:medium)
    end

    def is_full_video?
      @post.is_full_video
    end

    def full_video_url
      @post.video.url(:medium)
    end

    def url_html
      @post.url_html
    end

    def url
      @post.url
    end

    def has_content?
      @post.has_content
    end

    def has_content
      @post.has_content
    end

    def exclusive
      @post.is_exclusive
    end
  end
end
