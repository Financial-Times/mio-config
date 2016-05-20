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
      action 'Groovy Script Factory'
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
      storage_name 'S3 Bucket Factory'
      workflow_name 'Workflow'
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
      nodes [{name: 'End 1', path: '/e', type: 'END'},
             {name: 'Start 1', path: '/s', type: 'START'}]

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


    factory :metadata_definition do
      name 'metadata-definition'
      displayName 'Metadata_definition Display name'
      searchable :true
      editable :true
      required :true
      start :false

      testOptions = [{name: 'test', displayName: 'test', default: false, value: 'http://api.ft.com/things/test'}]

      checkBoxOptions = [{name: 'true', displayName: 'True', default: true, value: 'true'},
                         {name: 'false', displayName: 'False', default: false, value: 'false'}]

      urlStringsTest = [{name: 'file-name',
                         displayName: 'Poster File Name',
                         description: 'Poster File Name',
                         type: 'string',
                         searchable: true,
                         editable: true,
                         required: true,
                         formType: 'text',
                         maxLength: -1},
                        {name: 'file-path',
                         displayName: 'Poster File Path',
                         description: 'Poster File Path',
                         type: 'string',
                         searchable: true,
                         editable: true,
                         required: true,
                         formType: 'text',
                         maxLength: -1}]

      definitions [{name: 'section',
                      displayName: 'Section',
                      description: 'ft site section',
                      type: 'single-option',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      maxLength: -1,
                      options: testOptions
                     },
                     {name: 'brand',
                      displayName: 'Brand',
                      description: 'brand',
                      type: 'single-option',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      maxLength: -1,
                      options: testOptions
                     },
                     {name: 'headline',
                      displayName: 'Headline',
                      description: 'describe what the project is about',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'long-lead',
                      displayName: 'Long Lead',
                      description: 'long lead',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'short-lead',
                      displayName: 'Short Lead',
                      description: 'Short Lead',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'link-1',
                      displayName: 'Link 1',
                      description: 'Link 1',
                      type: 'url',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'text',
                      maxLength: -1
                     },
                     {name: 'link-2',
                      displayName: 'Link 2',
                      description: 'Link 2',
                      type: 'url',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'text',
                      maxLength: -1
                     },
                     {name: 'link-3',
                      displayName: 'Link 3',
                      description: 'Link 3',
                      type: 'url',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'text',
                      maxLength: -1
                     },
                     {name: 'credit',
                      displayName: 'Credit',
                      description: 'Credit',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'ft-office',
                      displayName: 'FT Office',
                      description: 'FT Office',
                      type: 'single-option',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      maxLength: -1,
                      options: testOptions
                     },
                     {name: 'producer',
                      displayName: 'Producer',
                      description: 'Producer',
                      type: 'single-option',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      maxLength: -1,
                      options: testOptions
                     },
                     {name: 'video-editor',
                      displayName: 'Video Editor',
                      description: 'Video Editor',
                      type: 'single-option',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      maxLength: -1,
                      options: testOptions
                     },
                     {name: 'freelance-video-editor',
                      displayName: 'Freelance Video Editor',
                      description: 'Freelance Video Editor',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'restrictions',
                      displayName: 'Restrictions',
                      description: 'Restrictions',
                      type: 'boolean',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'checkbox',
                      maxLength: -1,
                      options: checkBoxOptions
                     },
                     {name: 'restrictions-description',
                      displayName: 'Restrictions Description',
                      description: 'Restrictions Description',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      maxLength: 100
                     },
                     {name: 'poster-image',
                      displayName: 'Poster Image',
                      description: 'Poster Image',
                      type: 'image',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'file',
                      maxLength: -1,
                      strings: urlStringsTest
                     },
                     {name: 'thumbname-image',
                      displayName: 'Thumbnail Image',
                      description: 'Thumbnail Image',
                      type: 'image',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'file',
                      maxLength: -1,
                      strings: urlStringsTest
                     }]

      trait :empty_definitions do
        definitions []
      end

      factory :metadata_definition_invalid_data,      traits: [:invalid_name]
      factory :metadata_definition_extra_data,        traits: [:invalid_field]
      factory :metadata_definition_empty_definitions, traits: [:empty_definitions]

    end

  end
end
