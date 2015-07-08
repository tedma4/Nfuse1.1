module Twitter::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://twitter.com/"
    end

    def link_to_tweet
      base_uri << "#{@tweet.user.screen_name}/status/#{@tweet.id}"
    end

    #def user_url
    #  base_uri << "#{@tweet["user"]["screen_name"]}"
    #end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end