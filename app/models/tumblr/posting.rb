require_relative 'api'

module Tumblr
  class Posting < TimelineEntry

  attr_reader :user  
  
  include Api

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    # 
    def like_score(id)
      # Implement counter cache per / Records
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def comment_count(id)
      Comment.where(commentable_id: id).count
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def created_time
      @post['date']
    end

    def provider
      "tumblr"
    end

    def id
      @post['id']
    end

    def link_to_post
      @post['post_url']
    end

    def caption_text
      @post['caption'].html_safe
    end

    def photo
      @post['photos'][0]['alt_sizes'][0]['url']
    end

    def video
      @post['player'][0]['embed_code'].match(/src="(.*)\?/)[1]
    end

    def audio
      @post['player']
    end

    def type
      @post['type']
    end

    def body
      @post['body'].html_safe
    end

    def text
      @post['text'].html_safe
    end

    def link_to_url
      @post['url']
    end

    def description
      @post['description'].html_safe
    end
    def excerpt
      @post['excerpt']
    end
  end
end


# => {"blog_name"=>"tedma4", 
#   "id"=>122896460043, 
#   "post_url"=>"http://tedma4.tumblr.com/post/122896460043/description-for-audio-post-tumblr-sucks", 
#   "slug"=>"description-for-audio-post-tumblr-sucks", 
#   "type"=>"audio", 
#   "date"=>"2015-07-01 00:22:04 GMT", 
#   "timestamp"=>1435710124, 
#   "state"=>"published", 
#   "format"=>"html", 
#   "reblog_key"=>"pM6MFqGD", 
#   "tags"=>[], 
#   "short_url"=>"http://tmblr.co/ZTjFAk1oTCoaB", 
#   "recommended_source"=>nil, 
#   "followed"=>false, 
#   "highlighted"=>[], 
#   "liked"=>false, 
#   "note_count"=>0, 
#   "source_url"=>"https://soundcloud.com/zedd/zedd-i-want-you-to-know-feat-selena-gomez-milo-otis-remix", 
#   "source_title"=>"SoundCloud / Zedd", 
#   "track_name"=>"Zedd - I Want You to Know (feat. Selena Gomez) Milo & Otis Remix", 
#   "album_art"=>"https://31.media.tumblr.com/tumblr_nqs90swVqA1uznod7_1435710124_cover.jpg", 
#   "caption"=>"<p>Description for audio post. Tumblr sucks</p>", 
#   "reblog"=>{"tree_html"=>"", 
#     "comment"=>"<p>Description for audio post. Tumblr sucks</p>"
#     }, 
#   "trail"=>[{
#     "blog"=>{
#             "name"=>"tedma4", 
#             "theme"=>{
#               "avatar_shape"=>"square", 
#               "background_color"=>"#FAFAFA", 
#               "body_font"=>"Helvetica Neue", 
#               "header_bounds"=>"", 
#               "header_image"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
#               "header_image_focused"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
#               "header_image_scaled"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
#               "header_stretch"=>true, 
#               "link_color"=>"#529ECC", 
#               "show_avatar"=>true, 
#               "show_description"=>true, 
#               "show_header_image"=>true, 
#               "show_title"=>true, 
#               "title_color"=>"#444444", 
#               "title_font"=>"Gibson", 
#               "title_font_weight"=>"bold"
#               }
#               }, 
#     "post"=>{
#       "id"=>122896460043
#       },
#       "content"=>"<p>Description for audio post. Tumblr sucks</p>", 
#       "content_raw"=>"<p>Description for audio post. Tumblr sucks</p>", 
#       "is_current_item"=>true, 
#       "is_root_item"=>true
#       }
#       ], 
#       "player"=>"<iframe src=\"https://w.soundcloud.com/player/?url=https%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F200059902&amp;visual=true&amp;liking=false&amp;sharing=false&amp;auto_play=false&amp;show_comments=false&amp;continuous_play=false&amp;origin=tumblr\" frameborder=\"0\" allowtransparency=\"true\" class=\"soundcloud_audio_player\" width=\"500\" height=\"500\"></iframe>", 
#       "embed"=>"<iframe src=\"https://w.soundcloud.com/player/?url=https%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F200059902&amp;visual=true&amp;liking=false&amp;sharing=false&amp;auto_play=false&amp;show_comments=false&amp;continuous_play=false&amp;origin=tumblr\" frameborder=\"0\" allowtransparency=\"true\" class=\"soundcloud_audio_player\" width=\"500\" height=\"500\"></iframe>", 
#       "plays"=>0, 
#       "audio_url"=>"https://api.soundcloud.com/tracks/200059902/stream?client_id=3cQaPshpEeLqMsNFAUw1Q", 
#       "audio_source_url"=>"https://soundcloud.com/zedd/zedd-i-want-you-to-know-feat-selena-gomez-milo-otis-remix", 
#       "is_external"=>true, 
#       "audio_type"=>"soundcloud", 
#       "can_reply"=>false}
