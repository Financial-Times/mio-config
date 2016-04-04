FactoryGirl.define do
  factory :model, class: Hashie::Mash do
    visibility [4]
    enable :true
    start :true

    trait :invalid_name do
      name 123456
    end

    trait :invalid_field do
      foo 'bar'
    end

    factory :s3 do
      name 'An S3 Test Resource'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'

      factory :s3_invalid_data, traits: [:invalid_name]
      factory :s3_extra_data,   traits: [:invalid_field]
    end

    factory :hotfolder do
      name 'A Test Hotfolder Resource'
      storage_name 'An S3 Test Resource'
      workflow_name 'Import Jizz'
      owner 'masteruser masteruser'

      factory :hotfolder_invalid_data, traits: [:invalid_name]
      factory :hotfolder_extra_data,   traits: [:invalid_field]
    end

  end
end
