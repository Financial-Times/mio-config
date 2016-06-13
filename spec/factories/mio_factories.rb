FactoryGirl.define do
  factory :mio do
    base_uri 'https://example.com/api'
    username 'masteruser'
    password 'm4st3rus3r'

    initialize_with{ new(base_uri,username,password) }
  end
end
