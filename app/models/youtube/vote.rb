module Youtube
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'

    before_create { |record|
      record.social_flag = 'google_oauth2'
      record.vote_flag = true
    }
  end
end