require 'spec_helper'

describe Twitter::Post do 

  it 'should include Twitter::Api' do
    expect(Twitter).to have_constant(:Api)
  end

  # Proper inheritance
  it 'inherits from TimelineEntry' do
    expect(Twitter::Post.ancestors).to include(TimelineEntry)
  end

end