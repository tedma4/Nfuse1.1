module Vimeo
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'

    before_create { |record|
      record.social_flag = 'vimeo'
      record.vote_flag = true
    }
  end
end