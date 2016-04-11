module Nfuse
  class Comment
    delegate :created_at, :user, :body, :id, to: :comment

    attr_reader :provider
    attr_accessor :comment

    def initialize(comment)
      @comment = comment
      @provider = "nfuse"
    end

    def created_time
      @comment.created_at
    end
    
    def avatar
      @comment.user.avatar(:small)
    end

    def profile
      @comment.user
    end

    def full_name
      @comment.user.full_name
    end

    def body
      @comment.body
    end
  end
end