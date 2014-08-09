class AddBioColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :intro, :text
    add_column :users, :gender, :integer, default: 1
    add_column :users, :birthdate, :datetime
    add_column :users, :height, :integer
    add_column :users, :relationship_status, :integer, default: 1
    add_column :users, :interested_in, :integer, default: 1
    add_column :users, :looking_for, :integer, default: 1
    add_column :users, :religious_views, :string
    add_column :users, :hometown, :string
    add_column :users, :political_views, :string
    add_column :users, :occupation, :string
    add_column :users, :skills, :string
    add_column :users, :phone_number, :string
    add_column :users, :fav_movie, :string
    add_column :users, :fav_book, :string
    add_column :users, :fav_music, :string
    add_column :users, :fav_food, :string
    add_column :users, :fav_quote, :string
    add_column :users, :movie_or_play, :string
    add_column :users, :wishes, :string
    add_column :users, :tv_or_book, :string
    add_column :users, :invisible_or_read_minds, :string
    add_column :users, :lottery_or_perfect_job, :string
    add_column :users, :visit_any_country, :string
    add_column :users, :fail_or_never_try, :string
    add_column :users, :meet_in_history, :string
    add_column :users, :nobody_judges_you, :string
    add_column :users, :change_about_the_world, :string
  end
end
