require 'spec_helper'

describe 'Static Pages Routing', type: :routing do

  it 'routes all static pages correctly' do
   ['help',
    'about',
    'feedback',
    'terms',
    'privacy',
    'qanda'
    ].each do |page|
      expect(get(page)).to route_to("pages##{page}")
    end
  end
end