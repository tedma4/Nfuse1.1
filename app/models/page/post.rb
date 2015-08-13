module Page
	class Post < TimelineEntry

    def self.from(post)
      new(post)
    end

    def initialize(post)
      @post = post
    end

    def avatar

    end

    def username

    end

    #-----------id----------

    def id
    	if #instagram
      	@post["id"]
	    else
	    	@post.id
	    end
    end

    #-----------type----------

    def type
    	if #instagram
      	@post["type"]
    	elsif #twitter
     	  @post.attrs[:extended_entities][:media][0][:type]
     	end
    end

    #-----------text----------

    def text
    	if #instagram
    		@post['caption']['text']
    	elsif #twitter
    		@post.text
    	else
    		@post.description
    	end
    end

    #-----------image----------

    def image
    	if #instagram
      	@post["images"]["low_resolution"]["url"]
      elsif #twitter
      	@post.attrs[:extended_entities][:media][0][:media_url]
      end
    end

    #-----------video----------

    def video
    	if #instagram
      	@post["videos"]["standard_resolution"]["url"]
    	elsif #twitter
      	@post.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
      else
      	@post.id
      end	      	
    end

    #-----------link----------

    def link_to_post
    	if #instagram
     	  @post["link"]
    	elsif #twitter
     	  "https://twitter.com/#{username}/status/#{id}"
    	elsif #youtube
    	  "https://www.youtube.com/watch?v=#{@post.id}"
    	end
    end

    #-----------created_at----------
    def created_time
    	if #instagram
      	Time.at(@post["created_time"].to_i)
    	elsif #twitter
    		@post.created_at
      elsif #youtube
      	@post.published_at
      end
    end


    #-----------other----------

    def has_media?
      @post.attrs.has_key? :extended_entities
    end
	end
end
