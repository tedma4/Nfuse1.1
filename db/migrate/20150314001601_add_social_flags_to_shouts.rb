class AddSocialFlagsToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :social_key, :string
    add_column :shouts, :social_id, :string

    add_index  :shouts, :social_id, unique: true
  end
end
