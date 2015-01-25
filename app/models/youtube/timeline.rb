#module Youtube
#
#  class Timeline
#
#    attr_reader :authed, :youtube_pagination_id
#
#    def initialize(user)
#      @user = user
#      @authed = true
#    end
#
#    def posts(max_id)
#      token = @user.tokens.find_by(provider: 'youtube')
#      youtube_api = Api.new(token.access_token, max_id)
#      posts = []
#      begin
#        timeline = youtube_api.get_timeline
#        posts = timeline.posts
#          @pagination_max_id = timeline.pagination_max_id
#      rescue Unauthorized
#        @authed = false
#      end
#      posts
#    end
#
#  end
#
#end