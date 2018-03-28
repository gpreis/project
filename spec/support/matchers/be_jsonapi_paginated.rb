RSpec::Matchers.define :be_jsonapi_paginated do
  match do |json_response|
    must_have = %w[self first prev next last]

    (must_have & json_response['links'].keys).size == must_have.size
  end
end
