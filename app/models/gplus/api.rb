module Gplus::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://plus.google.com/"
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

