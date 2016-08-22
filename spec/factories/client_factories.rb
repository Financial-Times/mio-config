FactoryGirl.define do
  factory :client, class: Mio::Client do
    base_uri 'https://example.com'
    username 'masteruser'
    password 'm4st3rus3r'

    trait :dev_uri do
      base_uri 'https://master.dev.nativ-systems.com/api'
    end

    trait :invalid_creds do
      username Faker::Internet.user_name
      password Faker::Internet.password
    end

    factory :valid_client,         traits: [:dev_uri]
    factory :invalid_user_client,  traits: [:dev_uri, :invalid_creds]
    factory :invalid_client,       traits: [:invalid_creds]

    initialize_with{ new(base_uri,username,password) }
  end

  factory :create_json, class: OpenStruct do
    name 'vcr resource storage'
    visibilityIds [4]
    pluginClass "tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource"
  end

  factory :configure_json, class: OpenStruct do
    protocol 'S3'
    path "/"
    key "an-s3-key"
    secret "an-s3-secret-key"
    bucket "some-s3-bucket"
  end

  factory :action_json, class: OpenStruct do
    action 'enable'
  end

end
