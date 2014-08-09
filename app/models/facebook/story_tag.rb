module Facebook

  class StoryTag

    def self.from(story_tag)
      new(story_tag)
    end

    def initialize(story_tag)
      @story_tag = story_tag
    end

    def name
      @story_tag[1][0]["name"]
    end

    def type
      @story_tag[1][0]["type"]
    end

    def link_to_profile
      if type == "user"
        "https://www.facebook.com/app_scoped_user_id/#{@story_tag[1][0]["id"]}"
      end
    end

  end

end