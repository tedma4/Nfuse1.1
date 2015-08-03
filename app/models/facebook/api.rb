module Facebook::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://facebook.com/"
    end

    def link_to_post
      base_uri << "#{@post.user}/status/#{@post.id}"
    end

    #def user_url
    #  base_uri << "#{@post["user"]["screen_name"]}"
    #end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end