module Facebook

  class From

    def self.from(from_data)
      new(from_data)
    end

    def initialize(from_data)
      @from_data = from_data
    end

    def id
      @from_data["id"]
    end

    def link_to_profile
      "https://www.facebook.com/app_scoped_user_id/#{@from_data["id"]}"
    end

    def name
      @from_data["name"]
    end

  end

end