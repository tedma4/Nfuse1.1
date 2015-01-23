module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    page_title.empty? ? 'Nfuse' : ('Nfuse ' << page_title)
  end

  #This determines whether a user has a provider or not
  # You can still pass another user when using this method. It defaults to current user.
  def user_has_provider?(provider, user=current_user)
    user.tokens.by_name(provider).any?
  end  
end
