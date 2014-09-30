module UsersHelper

  def avatar_for(user)
    image_tag(user.avatar.url (:larger), alt: user.full_name)
  end

  def avatar_for_others(user)
    image_tag(user.avatar.url (:thumb), alt: user.full_name)
  end

  def conversation_interlocutor(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, 
      	:password_reset_token,
        :intro,
        :height,
        :relationship_status,
        :interested_in,
        :looking_for,
        :gender,
        :birthdate, 
        :religious_views,
        :hometown,
        :political_views,
        :occupation,
        :skills,
        :phone_number,
        :fav_movie,
        :fav_book,
        :fav_music,
        :fav_food,
        :fav_quote,
        :movie_or_play,
        :wishes,
        :tv_or_book,
        :invisible_or_read_minds,
        :lottery_or_perfect_job,
        :visit_any_country,
        :fail_or_never_try,
        :meet_in_history,
        :nobody_judges_you,
        :change_about_the_world
        )
    end

    # Before filters

    def correct_user
      @user = User.find(session[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
