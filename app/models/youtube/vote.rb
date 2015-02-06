module Youtube
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'

    before_create { |record|
      record.social_flag = 'youtube'
      record.vote_flag = true
    }
  end
end