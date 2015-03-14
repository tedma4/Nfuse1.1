class AddSocialFlagsToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :social_key, :string
    add_column :shouts, :social_id, :decimal
  end
end
