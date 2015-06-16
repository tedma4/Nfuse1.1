module Gplus::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://plus.google.com/"
    end

    def link_to_post
      base_uri << "#{@post["user"]["id"]}/post/#{@post["id"]}"
    end

    # def user_url
    #   base_uri << "#{@post["user"]["id"]}"
    # end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

