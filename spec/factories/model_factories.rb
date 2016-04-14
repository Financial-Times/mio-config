FactoryGirl.define do
  factory :model, class: OpenStruct do
    visibility [4]
    enable :true

    trait :invalid_name do
      name 123456
    end

    trait :invalid_field do
      foo 'bar'
    end

    factory :s3 do
      name 'S3 Bucket Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      start :true

      factory :s3_invalid_data, traits: [:invalid_name]
      factory :s3_extra_data,   traits: [:invalid_field]
    end

    factory :hotfolder do
      name 'Hotfolder Factory'
      storage_name 'An S3 Test Resource'
      workflow_name 'Import Jizz'
      owner 'masteruser masteruser'
      start :true

      factory :hotfolder_invalid_data, traits: [:invalid_name]
      factory :hotfolder_extra_data,   traits: [:invalid_field]
    end

    factory :import_action do
      name 'Import Action Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      start :true

      factory :import_action_invalid_data, traits: [:invalid_name]
      factory :import_action_extra_data,   traits: [:invalid_field]
    end

    factory :groovy_script do
      name 'Groovy Script Factory'
      displayName 'A Test Groovy Script'
      key 'some_s3_key'
      secret 'some_s3_secret'
      script 'test script'
      jars ['file:///test/test/jar','file:///test/test/test.jar']
      imports ['com.test.test.test','com.testing.testing.test']
      start :true

      factory :groovy_script_invalid_data, traits: [:invalid_name]
      factory :groovy_script_extra_data,   traits: [:invalid_field]
    end

    factory :workflow do
      name 'Workflow'
      transitions []
      nodes []

      factory :workflow_invalid_data, traits: [:invalid_name]
      factory :workflow_extra_data,   traits: [:invalid_field]
    end
  end
end
