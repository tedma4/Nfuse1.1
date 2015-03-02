class AddColumnsToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :refresh_token, :string
    add_column :tokens, :expiresat, :datetime
  end
end
