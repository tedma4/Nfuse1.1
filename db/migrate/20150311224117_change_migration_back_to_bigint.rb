class ChangeMigrationBackToBigint < ActiveRecord::Migration
  def self.up
    # execute <<-SQL
    #   ALTER TABLE votes
    #   ALTER COLUMN votable_id TYPE bigint USING votable_id::bigint
    # SQL
    change_column :votes, :votable_id, :bigint
  end

  def self.down
    change_column :votes, :votable_id, :string
    # execute <<-SQL
    #   ALTER TABLE votes
    #   ALTER COLUMN votable_id TYPE string
    # SQL
  end
end
