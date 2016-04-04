FactoryGirl.define do
  factory :mio do
    base_uri 'https://example.com/api'
    username 'masteruser'
    password 'masteruser'

    initialize_with{ new(base_uri,username,password) }
  end
end
