class Providers
  attr_reader :user

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

  def none?
    !(facebook? || twitter? || instagram?)
  end

end