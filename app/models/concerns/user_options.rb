module UserOptions
  extend ActiveSupport::Concern

  #This concatinates the user's first and last names
  def full_name
  new_name = first_name.capitalize + " " + last_name.capitalize
  final_name = new_name.split(' ').each(&:capitalize!).join(' ')
  end
  #These are the relationship status options a user can choose from
  def rel_stat
    ["I don’t want to say",
     "Single",
     "In a relationship",
     "Engaged",
     "Married",
     "It’s complicated",
     "In an open relationship",
     "Widowed",
     "In a domestic partnership",
     "In a civil union"][self.relationship_status - 1]
  end
#These are the interested in options a user can choose from
  def int_in
    ["Women", "Men", "Women and Men"][self.interested_in - 1]
  end

#These are the looking for options a user can choose from
  def look
    ["Friends", "Dating", "A relationship", "Networking", "Fun"][self.looking_for - 1]
  end

#These are the gender options a user can choose from
  def gender_txt
    ["Not Telling", "Male", "Female"][self.gender - 1]
  end

end