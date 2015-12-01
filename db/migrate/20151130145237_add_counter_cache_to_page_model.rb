class AddCounterCacheToPageModel < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_counter_cache, default: 0
    end
  end
end
