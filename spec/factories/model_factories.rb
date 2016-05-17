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

      sectionOptions = [{name: 'Markets &amp; Investing', displayName: 'Markets &amp; Investing', default: false, value: 'Markets &amp; Investing'},
                        {name: 'Companies &amp; Management', displayName: 'Companies &amp; Management', default: false, value: 'Companies &amp; Management'},
                        {name: 'World &amp; Economy', displayName: 'World &amp; Economy', default: false, value: 'World &amp; Economy'},
                        {name: 'Life &amp; Arts', displayName: 'Life &amp; Arts', default: false, value: 'Life &amp; Arts'}]

      brandOptions = [{name: 'SV', displayName: 'Markets - Short View (SV)', default: false, value: 'SV'},
                      {name: 'AUTH', displayName: "Markets - John Authers' Note (AUTH)", default: false, value: 'AUTH'},
                      {name: 'MKTS', displayName: 'Markets - FT Markets (MKTS)', default: false, value: 'MKTS'},
                      {name: 'FTFM', displayName: 'Markets - FTFM (FTFM)', default: false, value: 'FTFM'},
                      {name: 'FTTR', displayName: 'Markets - Trading Room (FTTR)', default: false, value: 'FTTR'},
                      {name: 'EMKT', displayName: 'Markets - FT Emerging Markets (EMKT)', default: false, value: 'EMKT'},
                      {name: 'BUS', displayName: 'Companies - FT Business (BUS)', default: false, value: 'BUS'},
                      {name: 'LEX', displayName: 'Companies - Lex (LEX)', default: false, value: 'LEX'},
                      {name: 'VFTT', displayName: 'Companies - View from the Top (VFTT)', default: false, value: 'VFTT'},
                      {name: 'BSCL', displayName: 'Companies - Business School (BSCL)', default: false, value: 'BSCL'},
                      {name: 'WRLD', displayName: 'World - FT World (WRLD)', default: false, value: 'WRLD'},
                      {name: 'LUCE', displayName: 'World - Luce Talk (LUCE)', default: false, value: 'LUCE'},
                      {name: 'ANRV', displayName: 'World - Analysis Review (ANRV)', default: false, value: 'ANRV'},
                      {name: 'CMNT', displayName: 'World - FT Comment (CMNT)', default: false, value: 'CMNT'},
                      {name: 'ALST', displayName: 'World - A list (ALST)', default: false, value: 'ALST'},
                      {name: 'FFT', displayName: 'World - FirstFT (FFT)', default: false, value: 'FFT'},
                      {name: 'ARTS', displayName: 'Life - FT Arts (ARTS)', default: false, value: 'FFT'},
                      {name: 'LIFE', displayName: 'Life - FT Life (LIFE)', default: false, value: 'LIFE'},
                      {name: 'WLTH', displayName: 'Life - FT Wealth (WLTH)', default: false, value: 'WLTH'},
                      {name: 'SP', displayName: 'Life - Special Projects (SP)', default: false, value: 'SP'},
                      {name: 'LAA', displayName: 'Life - FT Life &amp; Arts (LAA)', default: false, value: 'LAA'}]

      definitions [{name: 'project',
                      description: 'describe what the project is about',
                      type: 'text',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'textarea',
                      validationHandler: 'tv.nativ.mio.metadata.variable.def.validation.MaxLengthValidationHandler'
                     },
                     {name: 'section',
                      description: 'section',
                      type: 'string',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      options: sectionOptions
                     },
                     {name: 'brand',
                      description: 'brand',
                      type: 'string',
                      searchable: true,
                      editable: true,
                      required: true,
                      formType: 'select',
                      options: brandOptions}]

      trait :empty_definitions do
        definitions []
      end

      factory :metadata_definition_invalid_data,      traits: [:invalid_name]
      factory :metadata_definition_extra_data,        traits: [:invalid_field]
      factory :metadata_definition_empty_definitions, traits: [:empty_definitions]

    end

  end
end
