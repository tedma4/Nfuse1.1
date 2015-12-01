class Page < ActiveRecord::Base
  is_impressionable :counter_cache => true, :column_name => :page_counter_cache
end