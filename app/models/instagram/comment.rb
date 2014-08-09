module Instagram

  class Comment < TimelineEntry

    def self.from(comment)
      new(comment)
    end

    def initialize(comment)
      @comment = comment
      @created_time = Time.at(@comment["created_time"].to_i)
    end

    def text
      @comment["text"]
    end

    def username
      @comment["from"]["username"]
    end

    def profile_picture
      @comment["from"]["profile_picture"]
    end

    def link_to_profile
      "http://www.instagram.com/#{@comment["from"]["username"]}"
    end

    def full_name
      @comment["from"]["full_name"]
    end

  end

end