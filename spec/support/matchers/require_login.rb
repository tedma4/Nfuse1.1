RSpec::Matchers.define :require_signin do  |expected|
  match do |actual|
    expect(actual).to redirect_to Rails.application.routes.url_helpers.signin_url
  end

  failure_message do |actual|
    'Expected to require login - to access this method'
  end

  failure_message_when_negated do |actual|
    'Expected not to require login'
  end

  description do
    'redirect to login form'
  end
end

RSpec::Matchers.define :have_constant do |constant|
  match do |owner|
    owner.const_defined?(constant)
  end
end
