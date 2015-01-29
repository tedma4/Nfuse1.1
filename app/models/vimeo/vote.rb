module Vimeo
  class Vote < ActsAsVotable::Vote
    self.inheritance_column = 'votable_type'
  end
end