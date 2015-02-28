module Vimeo
	class Post < TimelineEntry

	  def self.get_client
	     Vimeo.new(:access_token => user.tokens.find_by(provider: "vimeo").token)
	  end

	  def get_timeline
	    vimeo_provider = @user.tokens.where(provider: "vimeo").first
	    if vimeo_provider 
	      @clientv = Vimeo::Advanced::Video.new(ENV["VIMEO_KEY"], ENV["VIMEO_SECRET"],
	        :token => vimeo_provider.token,
	        :secret => vimeo_provider.secret)
	      @videos = @clientv.get_all(vimeo_provider.uid)
	    end
  	end

	end
end