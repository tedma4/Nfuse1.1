class AddCounterCacheToShouts < ActiveRecord::Migration
  def change
    add_column :shouts, :cached_votes_total, :integer, :default => 0
    add_column :shouts, :cached_votes_score, :integer, :default => 0
    add_index  :shouts, :cached_votes_total
    add_index  :shouts, :cached_votes_score
    Shout.find_each(&:update_cached_votes)
  end
end
