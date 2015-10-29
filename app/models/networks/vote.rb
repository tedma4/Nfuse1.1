module Networks
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'
    provider = params['provider']
    before_create { |record|
      record.social_flag = provider
      record.vote_flag = true
    }
  end
end