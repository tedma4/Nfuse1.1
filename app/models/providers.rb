class Providers

  def self.for(user)
    new(user)
  end

  def initialize(user)
    @user = user
  end

  def facebook?
    @user.tokens.where(provider: 'facebook').count > 0
  end

  def twitter?
    @user.tokens.where(provider: 'twitter').count > 0
  end

  def instagram?
    @user.tokens.where(provider: 'instagram').count > 0
  end

  def google_oauth2?
    @user.tokens.where(provider: 'google_oauth2').count > 0
  end

  def vimeo?
    @user.tokens.where(provider: 'vimeo').count > 0
  end

  def nfuse?
    @user.posts.where(provider: 'nfuse').count > 0 
  end

  def none?
    !(facebook? || twitter? || instagram? || google_oauth2? || vimeo? || nfuse?)
  end

end