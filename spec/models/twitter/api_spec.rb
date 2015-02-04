require 'spec_helper'

describe  Twitter::Post do

  it 'should include Twitter::Api' do
    expect(Twitter).to have_constant(:Api)
  end

end

describe Twitter::Api do
  # 
end