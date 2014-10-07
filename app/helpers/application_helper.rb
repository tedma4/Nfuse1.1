module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Nfuse"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  #This determines whether a user has a provider or not
  def user_has_provider?(provider, user = current_user)
    user.tokens.by_name(provider).any?
  end  
end
