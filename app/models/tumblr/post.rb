require_relative 'api'

module Tumblr
  class Post < TimelineEntry

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
      @post.created_at
    end

    def provider
      "tumblr"
    end

    def post_id
      @post['posts'][0]['id']
    end

    def link_to_post
      @post['posts'][0]['post_url']
    end

    def caption
      @post['posts'][0]['caption']
    end

    def photo
      @post.object.attachments[0]["image"]["url"]
    end

    def video
      if @post['posts'][0].has_key? "embed_code"
        @post['posts'][0]["embed"]["url"]
      else
        @post['posts'][0]["photo"]["url"]
      end
    end

    def type
    end
  end
end

# @post['posts'][0]['id']
# @post['posts'][0]['post_url']
# @post['posts'][0]['type'] video, photo, link, quote
# @post['posts'][0]['caption']

# => {
# "posts"=>[
# {

# "blog_name"=>"tedma4", 
# "id"=>122313500593, 
# "post_url"=>"http://tedma4.tumblr.com/post/122313500593/my-awesome-caption", 
# "slug"=>"my-awesome-caption", 
# "type"=>"video", 
# "date"=>"2015-06-24 05:07:24 GMT", 
# "timestamp"=>1435122444, 
# "state"=>"published", 
# "format"=>"html", 
# "reblog_key"=>"q8khzK2B", 
# "tags"=>[], 
# "short_url"=>"http://tmblr.co/ZTjFAk1nwS_Un", 
# "recommended_source"=>nil, 
# "highlighted"=>[], 
# "note_count"=>0, 
# "caption"=>"<p>My awesome caption </p>", 

# "reblog"=>{
# "tree_html"=>"", 
# "comment"=>"<p>My awesome caption&nbsp;</p>"
# }, 

# "trail"=>[
# {
# "post"=>{
# "id"=>"122313500593"
# }, 
# "content"=>"<p>My awesome caption </p>", 
# "content_raw"=>"<p>My awesome caption&nbsp;</p>", 
# "is_current_item"=>true, 
# "is_root_item"=>true
# }
# ], 
# "permalink_url"=>"https://www.youtube.com/watch?v=yZqmarGShxg", 
# "html5_capable"=>true, 
# "thumbnail_url"=>"https://i.ytimg.com/vi/yZqmarGShxg/hqdefault.jpg", 
# "thumbnail_width"=>480, 
# "thumbnail_height"=>360, 
# "player"=>[
# {
# "width"=>250, 
# "embed_code"=>"<iframe width=\"250\" height=\"140\" src=\"https://www.youtube.com/embed/yZqmarGShxg?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
# }, 
# {
# "width"=>400, 
# "embed_code"=>"<iframe width=\"400\" height=\"225\" src=\"https://www.youtube.com/embed/yZqmarGShxg?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
# }, 
# {
# "width"=>500, 
# "embed_code"=>"<iframe width=\"500\" height=\"281\" src=\"https://www.youtube.com/embed/yZqmarGShxg?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
# }
# ], 
# "video_type"=>"youtube"
# }, 
# {
# "blog_name"=>"tedma4", 
# "id"=>122313369493, 
# "post_url"=>"http://tedma4.tumblr.com/post/122313369493/if-you-dont-give-up-on-getting-there-your-never", 
# "slug"=>"if-you-dont-give-up-on-getting-there-your-never", 
# "type"=>"quote", 
# "date"=>"2015-06-24 05:05:20 GMT", 
# "timestamp"=>1435122320, 
# "state"=>"published", 
# "format"=>"html", 
# "reblog_key"=>"rsofuVBl", 
# "tags"=>[], 
# "short_url"=>"http://tmblr.co/ZTjFAk1nwSUUL", 
# "recommended_source"=>nil, 
# "highlighted"=>[], 
# "note_count"=>0, 
# "text"=>"If you don&rsquo;t give up on getting there, your never on the wrong road", 
# "source"=>"Soichiro Kurobayashi", 
# "reblog"=>{
# "tree_html"=>"", 
# "comment"=>"<p>Soichiro Kurobayashi</p>"
# }
# }, 
# {
# "blog_name"=>"tedma4", 
# "id"=>122313259708, 
# "post_url"=>"http://tedma4.tumblr.com/post/122313259708/posting-tumblr", 
# "slug"=>"posting-tumblr", 
# "type"=>"link", 
# "date"=>"2015-06-24 05:03:41 GMT", 
# "timestamp"=>1435122221, 
# "state"=>"published", 
# "format"=>"html", 
# "reblog_key"=>"yeIowVvX", 
# "tags"=>[], 
# "short_url"=>"http://tmblr.co/ZTjFAk1nwS3gy", 
# "recommended_source"=>nil, 
# "highlighted"=>[],
# "note_count"=>0, 
# "title"=>"Posting | Tumblr", 
# "url"=>"https://www.tumblr.com/docs/en/posting", 
# "link_author"=>nil, 
# "excerpt"=>"Post anything (from anywhere!), 
# customize everything, and find and follow what you love. Create your own Tumblr blog today.", 
# "publisher"=>"tumblr.com", 
# "description"=>"<p>Posting to tumblr</p>", 
# "reblog"=>
# {
# "tree_html"=>"", 
# "comment"=>"<p>Posting to tumblr</p>"
# }, 
# "trail"=>[
# {
# "blog"=>{
# "name"=>"tedma4", 
# "theme"=>{
# "avatar_shape"=>"square", 
# "background_color"=>"#FAFAFA", 
# "body_font"=>"Helvetica Neue", 
# "header_bounds"=>"", 
# "header_image"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
# "header_image_focused"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", "header_image_scaled"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", "he
# ader_stretch"=>true, 
# "link_color"=>"#529ECC", 
# "show_avatar"=>true, 
# "show_description"=>true, 
# "show_header_image"=>true, 
# "show_title"=>true, 
# "title_color"=>"#444444", 
# "title_font"=>"Gibson", 
# "title_font_weight"=>"bold"
# }
# }, 
# "post"=>{
# "id"=>"122313259708"
# }, 
# "content"=>"<p>Posting to tumblr</p>", 
# "content_raw"=>"<p>Posting to tumblr</p>", 
# "is_current_item"=>true, 
# "is_root_item"=>true
# }
# ]
# }, 
# {
# "blog_name"=>"tedma4", 
# "id"=>122304055118, 
# "post_url"=>"http://tedma4.tumblr.com/post/122304055118/somethin-i-found", 
# "slug"=>"somethin-i-found", 
# "type"=>"photo", 
# "date"=>"2015-06-24 02:55:20 GMT", 
# "timestamp"=>1435114520, 
# "state"=>"published", 
# "format"=>"html", 
# "reblog_key"=>"mmsAUyeL", 
# "tags"=>[], 
# "short_url"=>"http://tmblr.co/ZTjFAk1nvuyTE", 
# "recommended_source"=>nil, 
# "highlighted"=>[], 
# "note_count"=>0, 
# "caption"=>"<p>Somethin I found</p>", 
# "reblog"=>{
# "tree_html"=>"", 
# "comment"=>"<p>Somethin I found</p>"
# }, 
# "trail"=>[
# {
# "blog"=>{
# "name"=>"tedma4", 
# "theme"=>{
# "avatar_shape"=>"square", 
# "background_color"=>"#FAFAFA", 
# "body_font"=>"Helvetica Neue", 
# "header_bounds"=>"", 
# "header_image"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
# "header_image_focused"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
# "header_image_scaled"=>"http://assets.tumblr.com/images/default_header/optica_pattern_14_focused_v3.png?_v=8c2d3b00544b7efbc4ac06dc3f80e374", 
# "header_stretch"=>true, 
# "link_color"=>"#529ECC", 
# "show_avatar"=>true, 
# "show_description"=>true, 
# "show_header_image"=>true, 
# "show_title"=>true, 
# "title_color"=>"#444444", 
# "title_font"=>"Gibson", 
# "title_font_weight"=>"bold"
# }
# }, 
# "post"=>{
# "id"=>"122304055118"
# }, 
# "content"=>"<p>Somethin I found</p>",
# "content_raw"=>"<p>Somethin I found</p>", 
# "is_current_item"=>true, 
# "is_root_item"=>true
# }
# ], 
# "image_permalink"=>"http://tedma4.tumblr.com/image/122304055118", 
# "photos"=>[
# {
# "caption"=>"", 
# "alt_sizes"=>[
# {
# "width"=>720, 
# "height"=>720, 
# "url"=>"https://41.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_1280.jpg"
# }, 
# {
# "width"=>500, 
# "height"=>500, 
# "url"=>"https://41.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_500.jpg"
# }, 
# {
# "width"=>400, 
# "height"=>400, 
# "url"=>"https://40.media.tumblr.com/a7f35aee880e3ce3617452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_400.jpg"
# }, 
# {
# "width"=>250, "height"=>250,
# "url"=>"https://36.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_250.jpg"
# }, 
# {
# "width"=>100, "height"=>100, 
# "url"=>"https://41.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_100.jpg"
# }, 
# {
# "width"=>75, "height"=>75, 
# "url"=>"https://40.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_75sq.jpg"
# }
# ], 
# "original_size"=>{
# "width"=>720, "height"=>720, 
# "url"=>"https://41.media.tumblr.com/a7f35aee880e3ce36177452c6e6edfb1/tumblr_nqfhg8SbDQ1uznod7o1_1280.jpg"
# }
# }
# ]
# }
# ], 
# "total_posts"=>4}
