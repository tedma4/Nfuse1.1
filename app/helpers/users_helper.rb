module UsersHelper

  def avatar_for(user)
    image_tag(user.avatar.url (:larger), alt: user.full_name)
  end

  def avatar_for_others(user)
    image_tag(user.avatar.url (:thumb), alt: user.full_name)
  end

end
