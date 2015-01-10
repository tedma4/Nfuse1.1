class AddBannerToUsers < ActiveRecord::Migration
  def self.up
    add_attachment :users, :banner
  end

  def self.down
    remove_attachment :users, :banner
  end
end
