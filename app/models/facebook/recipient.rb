module Facebook

  class Recipient

    def self.from(recipient_data)
      new(recipient_data["data"].first)
    end

    def initialize(recipient_data)
      @recipient_data = recipient_data
    end

    def id
      @recipient_data["id"]
    end

    def link_to_profile
      "https://www.facebook.com/app_scoped_user_id/#{@recipient_data["id"]}"
    end

    def name
      @recipient_data["name"]
    end

  end

end