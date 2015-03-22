module Vimeo::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://vimeo.com/"
    end

    def link_to_video
      base_uri << "#{@video["user"]["screen_name"]}/status/#{@video["id"]}"
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