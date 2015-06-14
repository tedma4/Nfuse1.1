module Gplus
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'

    before_create { |record|
      record.social_flag = 'gplus'
      record.vote_flag = true
    }
  end
end