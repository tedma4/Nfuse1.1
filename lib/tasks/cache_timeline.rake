namespace :timelines do
  desc "fetch user timelines"
  task :fetch_and_save => :environment do
    User.all.each do |user|
      if user.tokens.length > 0
        Cache::Providers.clear_user_posts(user)
        Cache::Providers.fetch_and_save_timelines(user)
      end
    end
  end
end