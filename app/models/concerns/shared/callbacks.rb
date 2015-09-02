module Shared::Callbacks
  extend ActiveSupport::Concern

  included do
    before_destroy :remove_activity
  end

  def remove_activity
    activity = PublicActivity::Activity.find_by_trackable_id_and_trackable_type(self.id, self.class.to_s)
    activity.destroy if activity.present?
    true
  end
end