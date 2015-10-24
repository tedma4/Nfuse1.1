module Flickr
  class Timeline

    # FlickRaw.api_key="... Your API key ..."
    # FlickRaw.shared_secret="... Your shared secret ..."

    # list   = flickr.photos.getRecent

    # id     = list[0].id
    # secret = list[0].secret
    # info = flickr.photos.getInfo :photo_id => id, :secret => secret

    # sizes = flickr.photos.getSizes :photo_id => id

    # original = sizes.find {|s| s.label == 'Original' }
    # puts original.width       # => "226" -- may fail if they have no original marked image

    attr_reader :authed, :last_vid_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(max_id = nil)
      timeline = get_timeline(client, max_id)
      store_last_post_id(timeline)
      timeline
    end

    def get_video(video_id)
      client.my_video(video_id)
    end

    def last_pic_id
      @last_post_id
    end

    private

    def client
      @client ||= configure_flickr(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "flickr")
    end

    def configure_flickr(tokens)
      @config ||= tokens.configure_flickr(tokens.access_token, tokens.access_token_secret)#, tokens.expiresat)
    end

    def get_timeline(client, max_id)
      # if max_id.nil?
        client.people.getPhotos('user_id' => @user.tokens.where('provider' => 'flickr').first.uid)
      # else
      #   flickr_timeline = client.getRecent( max_id: max_id, count: 50)
      #   flickr_timeline.delete_at(0)
      #   flickr_timeline
      # end
    end

    def store_last_post_id(timeline)
      if last = timeline[timeline.count-1]
        @last_post_id = last.id
      else
        @last_post_id = nil
      end
    end


  end
end

# FlickRaw.api_key="... Your API key ..."
# FlickRaw.shared_secret="... Your shared secret ..."

# token = flickr.get_request_token
# auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

# puts "Open this url in your process to complete the authication process : #{auth_url}"
# puts "Copy here the number given when you complete the process."
# verify = gets.strip

# begin
#   flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
#   login = flickr.test.login
#   puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
# rescue FlickRaw::FailedResponse => e
#   puts "Authentication failed : #{e.msg}"
# end
