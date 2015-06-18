module Vimeo::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://vimeo.com/"
    end

    def link_to_video
      @post.link
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