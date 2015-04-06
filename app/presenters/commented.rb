class Commented
  attr_reader :obj
  delegate :user, :body, :comments, to: :@obj

  def initialize(obj)
    @obj = obj
  end

  def id
    return obj.tweet_id if obj.class  == Twitter::Post
    return obj.id
  end

  def form_path
    routes = {
          'Twitter::Post' => "/comments/twitter/#{id}",
          'Facebook::Post' => "/comments/facebook/#{id}",
          'Instagram::Post' => "/comments/instagram/#{id}",
          'Youtube::Post' => "/comments/youtube/#{id}",
          'Vimeo::Post' => "/comments/vimeo/#{id}",
          'Pinterest::Post' => "/comments/pinterest/#{id}",
          'Flickr::Post' => "/comments/flickr/#{id}"
    }
    routes.fetch(obj.class.to_s, "/shouts/#{id}/comments")
  end

  def build(params)
    Comment.new(params)
  end

  def extras
    { commentable_type: obj.klass.to_s, commentable_id: obj.id }
  end

  def self.set(_klass, value)
    new(BaseComment.new(_klass, value))
  end

  BaseComment= Struct.new("BaseComment", :klass, :value) do
    def id
      value
    end
  end

end