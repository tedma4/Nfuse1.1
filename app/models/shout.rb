    class Shout < ActiveRecord::Base
    	require 'paperclip-ffmpeg'
      belongs_to :user  
      validates :user_id, presence: true
      has_many :comments, dependent: :destroy
      after_create :this_is_video!
      acts_as_votable

      attr_accessor :content, :pic, :photo_delete, :snip, :video_delete#, dependent: :destroy
      has_destroyable_file :pic, :snip

      has_attached_file :pic, :styles => { :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}

      validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png" ]

      has_attached_file :snip, :styles => {
                                :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
                                            }, :processors => [:ffmpeg, :qtfaststart]

      def this_is_video!
        update_attribute(:video, true) if !self.snip_file_name.nil?
      end


      def all_votes
        ActsAsVotable::Vote.where(votable_id: self.id)
      end
    end



