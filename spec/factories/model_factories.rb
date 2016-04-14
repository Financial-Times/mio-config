FactoryGirl.define do
  trait :invalid_name do
    name 123456
  end

  trait :invalid_field do
    foo 'bar'
  end

  factory :node, class: OpenStruct do
    name 'start 1'
    action ''
    type 'start'

    factory :node_invalid_data, traits: [:invalid_name]
    factory :node_extra_data,   traits: [:invalid_field]

    factory :end_node do
      name 'end 1'
      type 'end'
    end

    factory :action_node do
      name 'lauch 1'
      action 'Launch and Wait'
      type 'ACTION'
    end
  end

  factory :transition, class: OpenStruct do
    from 'start 1'
    to 'end 1'

    factory :transition_invalid_data do
      from 123
    end

    factory :transition_extra_data,   traits: [:invalid_field]
  end

  factory :model, class: OpenStruct do
    visibility [4]
    enable :true

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
      transitions [{from: 'Start 1', to: 'End 1'}]
      nodes [{id: 456, name: 'End 1', path: '/e'},
             {id: 123, name: 'Start 1', path: '/s'}]

      trait :empty_nodes do
        nodes []
      end

      trait :empty_transitions do
        transitions []
      end

      factory :workflow_invalid_data,      traits: [:invalid_name]
      factory :workflow_extra_data,        traits: [:invalid_field]
      factory :workflow_empty_nodes,       traits: [:empty_nodes]
      factory :workflow_empty_transitions, traits: [:empty_transitions]
    end

    factory :groovy_script_wait do
      name 'A Test Groovy Wait Script'
      displayName 'A Test Groovy Wait Script'
      key 'some_s3_key'
      secret 'some_s3_secret'
      script 'test script'
      jars ['file:///test/test/jar','file:///test/test/test.jar']
      imports ['com.test.test.test','com.testing.testing.test']
      timeout 0
      polling_time 10
      start :true

      factory :groovy_script_wait_invalid_data, traits: [:invalid_name]
      factory :groovy_script_wait_extra_data,   traits: [:invalid_field]
    end
  end
end
