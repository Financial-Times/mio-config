FactoryGirl.define do
  trait :invalid_name do
    name 123456
  end

  trait :invalid_field do
    foo 'bar'
  end

  trait :start_enable do
    start :true
    enable :true
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

      factory :definition_multiple_same_name_options do
        options [{name: 'test', displayName: 'True', default: true, value: 'true'},
                 {name: 'test', displayName: 'True', default: true, value: 'true'}]
      end

      factory :boolean_defintion do
        type 'boolean'

        factory :boolean_bad_name do
          options [{name: 'test', displayName: 'True', default: true, value: 'true'},
                   {name: 'false', displayName: 'True', default: true, value: 'false'}]
        end

        factory :boolean_name_value_dont_match do
          options [{name: 'true', displayName: 'True', default: true, value: 'false'},
                   {name: 'false', displayName: 'True', default: true, value: 'true'}]
        end

        factory :boolean_value_not_boolean do
          options [{name: 'true', displayName: 'True', default: true, value: 'true'},
                   {name: 'false', displayName: 'True', default: true, value: 'xxxx'}]
        end

        factory :boolean_name_false_value_not_false do
          options [{name: 'false', displayName: 'True', default: true, value: 'true'},
                   {name: 'true', displayName: 'True', default: true, value: 'true'}
                   ]
        end

        factory :boolean_single_option do
          options [{name: 'false', displayName: 'True', default: true, value: 'true'}
                  ]
        end

      end

    end

  end

  trait :invalid_type do
    type 123456
  end

  factory :workflowvariable, class: OpenStruct do
    type 'string'
    key 'teststringkey'
    value 'teststringvalue'

    factory :workflowvariable_invalid_data, traits: [:invalid_type]
    factory :workflowvariable_extra_data,   traits: [:invalid_field]

    factory :workflowvariable_object_variable do
      type 'object'
      key 'testobjectkey'
      value '13553'

      factory :workflowvariable_not_number_object_variable do
        value 'asdlkjasd'
      end

      factory :workflowvariable_not_known_object_variable do
        value '9999999999'
      end
    end

    factory :workflowvariable_date_variable do
      type 'date'
      key 'testdatekey'
      value '01-01-2016 11:00:00'

      factory :workflowvariable_bad_date_variable do
        value 'xxxxx'
      end
    end

    factory :workflowvariable_bad_type do
      type 'objectRR'
    end

    factory :workflowvariable_bad_date do
      type 'date'
      value 'notADate'
    end
  end

  factory :launchworkflow, class: OpenStruct do
    name "workflow-create-project"
    inheritVariables :true
    workFlowStringVariables [{key: 'teststringkey', type: 'string', value: 'teststring'}]
    workFlowObjectVariables [{key: 'testobjectkey', type: 'object', value: '13553'}]
    workflowDateVariables [{key: '', type: 'date', value: '01-01-2016 11:00:00'}]

    factory :launchworkflow_invalid_data, traits: [:invalid_name]
    factory :launchworkflow_extra_data, traits: [:invalid_field]

    factory :launchworkflow_unknown_metadata_definition do
      name "xxx?xxx"
    end
  end

  factory :model, class: OpenStruct do

    factory :s3, traits: [:start_enable] do
      name 'S3 Bucket Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      visibility [4]


      factory :s3_invalid_data, traits: [:invalid_name]
      factory :s3_extra_data,   traits: [:invalid_field]
    end

    factory :hotfolder, traits: [:start_enable] do
      name 'Hotfolder Factory'
      storage_name 'S3 Bucket Factory'
      workflow_name 'Workflow'
      owner 'masteruser masteruser'
      visibility [4]

      factory :hotfolder_invalid_data, traits: [:invalid_name]
      factory :hotfolder_extra_data,   traits: [:invalid_field]
    end

    factory :import_action, traits: [:start_enable] do
      name 'Import Action Factory'
      key 'some_s3_key'
      secret 'some_s3_secret'
      bucket 'some_faked_s3_bucket'
      variant "project-variant"
      metadataDefinition "project-metadata"
      sourceJsonVariable "testJsonVariable"
      s3PathVariable '${variables.assetS3Path}'
      assetTitleVariable '${variables.assetTitle}'
      visibility [4]

      factory :import_action_invalid_data, traits: [:invalid_name]
      factory :import_action_extra_data,   traits: [:invalid_field]

      factory :import_action_unknown_metadata_definition do
        metadataDefinition "xxxYYYUnknown9999"
      end
    end

    factory :groovy_script, traits: [:start_enable] do
      name 'Groovy Script Factory'
      displayName 'A Test Groovy Script'
      script 'test script'
      jars ['file:///test/test/jar','file:///test/test/test.jar']
      imports ['com.test.test.test','com.testing.testing.test']
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

    factory :groovy_script_wait, traits: [:start_enable] do
      name 'A Test Groovy Wait Script'
      displayName 'A Test Groovy Wait Script'
      script 'test script'
      jars ['file:///test/test/jar','file:///test/test/test.jar']
      imports ['com.test.test.test','com.testing.testing.test']
      timeout 0
      polling_time 10
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

      factory :variant_unknown_object_type do
        objectType 'xxx??xx'
      end

      factory :variant_unknown_metadata_definition do
        metadataDefinitions ['xxx??xx']
      end

    end

    factory :place_holder_group_asset_action, traits: [:start_enable] do
      name 'test-project-group-placeholder' 		      # Name of the place holder asset
      visibility [4] 				                          # IDs of accounts that may see this
      creationContext "NEW" 				                  # Creation context
      variantName "project-variant" 				          # Object Variant to create
      metadataDefinition "project-metadata" 		      # The metadata definition to associate to this place holder asset

      factory :place_holder_group_asset_action_invalid_data,                traits: [:invalid_name]
      factory :place_holder_group_asset_action_extra_data,                  traits: [:invalid_field]

      factory :place_holder_group_asset_action_unknown_metadata_definition do
        metadataDefinition "xxx?xxx"
      end
    end

    factory :message_template, traits: [:start_enable] do
      name 'create-project-email-template-100'
      visibility [4]
      subject 'NEW PROJECT: #{asset.mioObject.name}'
      priority "Normal"
      template '<p>Url: @[HTTPS_BASE_URL]/#mio=assets%2Casset%2Cindex.jsp%3Fid%3D#{asset.id}</p> <p>Project&nbsp;Owner: #{asset.owner.firstName}</p> <p>Project&nbsp;Created: #{asset.created}</p>'

      factory :message_template_invalid_data,                traits: [:invalid_name]
      factory :message_template_extra_data,                  traits: [:invalid_field]

    end

    factory :email_message_action do
      name 'project-create-email-action-testing' 		      # Name of the email message action
      visibility [4] 				                              # IDs of accounts that may see this
      template 'create-project-email-template-999'        # Id of email template
      recipientExpression '${job.mioObject.owner.email}'  # Evaluated Expression value which generates an email address
      start :true
      enable :false 				                              # :true or :false

      factory :email_message_action_invalid_data,                traits: [:invalid_name]
      factory :email_message_action_extra_data,                  traits: [:invalid_field]

      factory :email_message_action_unknown_message_template do
        template 'xxx?xxx'
      end
    end

    factory :account_property do
      name 'account_property'
      key 'account_property_key'
      value 'account_property_value'

      factory :account_property_invalid_data,                traits: [:invalid_name]
      factory :account_property_extra_data,                  traits: [:invalid_field]
    end

    factory :groovy_script_decision, traits: [:start_enable] do
      name 'Groovy Script Decision'
      displayName 'A Test Groovy Decision Script'
      script 'test script'
      jars ['file:///test/test/jar','file:///test/test/test.jar']
      imports ['com.test.test.test','com.testing.testing.test']
      visibility [4]

      factory :groovy_script_decision_invalid_data, traits: [:invalid_name]
      factory :groovy_script_decision_extra_data,   traits: [:invalid_field]
    end

    factory :add_to_group_action_empty_config, traits: [:start_enable] do
      name 'Testing Add to group action'
      visibility [4]
      targetAssetId ''
      groupName ''
      referenceNamePrefix ''

      factory :add_to_group_action_targetAssetId do
        targetAssetId 'test'
      end

      factory :add_to_group_action_groupName do
        groupName 'test'
      end

      factory :add_to_group_action_referenceNamePrefix do
        referenceNamePrefix 'test'
      end

      factory :add_to_group_action_empty_config_invalid_data, traits: [:invalid_name]
      factory :add_to_group_action_empty_config_extra_data, traits: [:invalid_field]

    end

    factory :launch_workflow_action, traits: [:start_enable] do

      name 'test-ingest-workflow-launcher'
      visibility [4]
      workflows [{"Workflow":{"id":13707},"inherit-variables":"true",
                  "workflow-string-variable": [{"string-variable-key":{"value":"test-key","isExpression":false},"string-variable-value":{"value":"test-value","isExpression":false}}],
                  "workflow-object-variable":[{"object-variable-key":{"value":"test-key","isExpression":false},"object-variable-value":{"value":"222","isExpression":false}}],
                  "workflow-date-variable":[{"date-variable-key":{"value":"test-key","isExpression":false},"date-variable-value":{"value":"01-01-2016 15:00:00","isExpression":false}}]
                 }]

      trait :empty_workflows do
        workflows []
      end

      factory :launch_workflow_action_invalid_data,      traits: [:invalid_name]
      factory :launch_workflow_action_extra_data,        traits: [:invalid_field]
      factory :launch_workflow_action_empty_workflows,   traits: [:empty_workflows]
    end

  end
end
