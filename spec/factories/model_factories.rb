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
    assetContext ''

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
      assetContext '.'
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

  factory :option, class: OpenStruct do
    name 'name'
    displayName 'displayName'
    default  :true
    value 'value'

    factory :option_invalid_data, traits: [:invalid_name]
    factory :option_extra_data,   traits: [:invalid_field]
  end

  factory :definition, class: OpenStruct do
    searchable :true
    editable :true
    required :true

    factory :text_metadata_definition, class: OpenStruct do
      name 'project'
      displayName 'Project'
      description 'describe what the project is about'
      type 'text'
      formType 'textarea'
      maxLength 100
      validationHandler 'tv.nativ.mio.metadata.variable.def.validation.MaxLengthValidationHandler'
      options []
      strings []

      factory :text_metadata_definition_invalid_data, traits: [:invalid_name]
      factory :text_metadata_definition_extra_data,   traits: [:invalid_field]
    end

  end

  factory :model, class: OpenStruct do

    factory :s3 do
      name 'S3 Bucket Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      start :true
      enable :true
      visibility [4]


      factory :s3_invalid_data, traits: [:invalid_name]
      factory :s3_extra_data,   traits: [:invalid_field]
    end

    factory :hotfolder do
      name 'Hotfolder Factory'
      storage_name 'S3 Bucket Factory'
      workflow_name 'Workflow'
      owner 'masteruser masteruser'
      start :true
      enable :true
      visibility [4]

      factory :hotfolder_invalid_data, traits: [:invalid_name]
      factory :hotfolder_extra_data,   traits: [:invalid_field]
    end

    factory :import_action do
      name 'Import Action Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      start :true
      enable :true
      visibility [4]

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
      enable :true
      visibility [4]

      factory :groovy_script_invalid_data, traits: [:invalid_name]
      factory :groovy_script_extra_data,   traits: [:invalid_field]
    end

    factory :workflow do
      name 'Workflow'
      transitions [{from: 'Start 1', to: 'End 1'}]
      nodes [{name: 'End 1', path: '/e', type: 'END', assetContext: ''},
             {name: 'Start 1', path: '/s', type: 'START', assetContext: ''}]
      enable :true
      visibility [4]

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
      enable :true
      visibility [4]

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
      enable :true
      visibility [4]

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
                     }]

      trait :empty_definitions do
        definitions []
      end

      factory :metadata_definition_invalid_data,      traits: [:invalid_name]
      factory :metadata_definition_extra_data,        traits: [:invalid_field]
      factory :metadata_definition_empty_definitions, traits: [:empty_definitions]
    end

    factory :variant do
      name 'project-variant' 				                      # Name of the Object Variant
      objectType 'project' 				                        # The Object which this varies
      defaultVariant :false 				                      # AWS API Key with access to bucket
      metadataDefinitions ['project-metadata']            # Array of metadata definitions
      defaultMetadataDefinition 'project-metadata' 				# Default metadata definition name

      trait :empty_metadata_definitions do
        metadataDefinitions []
      end

      factory :variant_invalid_data,                traits: [:invalid_name]
      factory :variant_extra_data,                  traits: [:invalid_field]
      factory :variant_empty_metadataDefinitions,   traits: [:empty_metadata_definitions]
    end

    factory :place_holder_group_asset_action do
      name 'test-project-group-placeholder' 		      # Name of the place holder asset
      visibility [4] 				                          # IDs of accounts that may see this
      creationContext "NEW" 				                  # Creation context
      variantName "project-variant" 				          # Object Variant to create
      metadataDefinition "project-metadata" 		      # The metadata definition to associate to this place holder asset
      start :true
      enable :true 				                            # :true or :false

      factory :place_holder_group_asset_action_invalid_data,                traits: [:invalid_name]
      factory :place_holder_group_asset_action_extra_data,                  traits: [:invalid_field]
    end

    factory :message_template do
      name 'project-create-email-template-testing'
      visibility [4]
      subject 'NEW PROJECT: #{asset.mioObject.name}'
      priority "Normal"
      template '<p>Url: @[HTTPS_BASE_URL]/#mio=assets%2Casset%2Cindex.jsp%3Fid%3D#{asset.id}</p> <p>Project&nbsp;Owner: #{asset.owner.firstName}</p> <p>Project&nbsp;Created: #{asset.created}</p>'
      start :true
      enable :true

      factory :message_template_invalid_data,                traits: [:invalid_name]
      factory :message_template_extra_data,                  traits: [:invalid_field]
    end

    factory :email_message_action do
      name 'project-create-email-action-testing' 		      # Name of the email message action
      visibility [4] 				                              # IDs of accounts that may see this
      template 'create-project-email-template-999'    # Id of email template
      recipientExpression '${job.mioObject.owner.email}'  # Evaluated Expression value which generates an email address
      start :true
      enable :false 				                              # :true or :false

      factory :email_message_action_invalid_data,                traits: [:invalid_name]
      factory :email_message_action_extra_data,                  traits: [:invalid_field]
    end

  end
end

