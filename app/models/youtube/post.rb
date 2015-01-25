#module Youtube
#	
#	class Post < TimelineEntry
#
#    def self.from(video)
#      new(youtube_api_hash)
#    end
#
#    def initialize(video)
#      @video = video
#      @created_time = Time.at(@video["created_time"].to_i)
#    end
#
#    def provider
#      "youtube"
#    end
#
#    def id
#      @video["id"]
#    end
#
#    def profile_picture
#      @video["user"]["profile_picture"]
#    end
#
#    def full_name
#      @video["user"]["full_name"]
#    end
#
#    def user_url
#      "http://www.instagram.com/#{full_name}"
#    end
#
#    def low_resolution_image_url
#      @video["images"]["low_resolution"]["url"]
#    end
#
#    def caption
#      @video["caption"]
#    end
#
#    def caption_text
#      @video["caption"]["text"]
#    end
#
#    def link_to_video
#      @video["link"]
#    end
#
#    def comments_count
#      @video["comments"]["count"].to_i
#    end
#
#    def comments
#      @video["comments"]["data"].map { |comment| Comment.from(comment) }
#    end
#
#    def likes_count
#      @video["likes"]["count"].to_i
#    end
#
#    def type
#      @video["type"]
#    end
#	end
#end