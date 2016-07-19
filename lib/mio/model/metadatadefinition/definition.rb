class Mio
  class Model
    class MetadataDefinition
      class Definition < Model
        set_resource :metadatadefinition

        field :name, String, 'Metadata Definition Name'
        field :displayName, String, 'Display name'
        field :type, String, 'Metdata type tsingle-option|text|url|boolean|image', 'text', /^(single-option|text|url|boolean|image|string)$/
        field :description, String, 'Metadata Definition Description'
        field :searchable, Symbol, 'Indexed and searchable', :true
        field :editable, Symbol, 'Editable field', :true
        field :required, Symbol, 'Required mandatory metadata item', :true
        field :isVisible, Symbol, 'Control visible', :true
        field :formType, String, 'Form control type', 'textarea' , /^(select|textarea|text|checkbox|file)$/
        field :maxLength, Fixnum, 'MaxLength', -1
        field :validationHandler, String, 'Validation handler', ''
        field :options, Array, 'Array of options', []
        field :strings, Array, 'Array of strings for use in componenets such as image', []

        nested true

        def create_hash
          {name: @args.name,
           displayName: @args.displayName,
           type: @args.type,
           description: @args.description,
           searchable: @args.searchable,
           editable: @args.editable,
           required: @args.required,
           formType: @args.formType,
           maxLength: @args.maxLength,
           validationHandler: @args.validationHandler,
           options: @args.options,
           strings: @args.strings,
           isVisible: @args.isVisible
          }
        end

        def validation_handler_by_type type
          case type
            when 'text'
              'tv.nativ.mio.metadata.variable.def.validation.MaxLengthValidationHandler'
            when 'image'
              'tv.nativ.mio.metadata.resource.def.MioFileVariable.FileValidationHandler'
            when 'string'
              'tv.nativ.mio.metadata.variable.def.validation.MaxLengthValidationHandler'
            when 'url'
              'tv.nativ.mio.metadata.resource.def.MioURLVariable$URLValidationHandler'
            when 'string'
              'tv.nativ.mio.metadata.variable.def.validation.MaxLengthValidationHandler'
            else
              ''
          end
        end

        def build_xml children, type=nil
          if type.nil?
            type = @args.type
          end
          children.send(type+'_', name: @args.name, display_name: @args.displayName) do |child|
            child.searchable @args.searchable.to_s
            child.editable @args.editable.to_s
            child.required @args.required
            child.isVisible @args.isVisible
            unless @args.maxLength.equal?(-1)
                child.send("max-length", @args.maxLength )
            end
            if @args.validation_handler.nil? || @args.validation_handler == ''
              child.validation handler: validation_handler_by_type(type)
            else
              child.validation handler: validation_handler
            end
            child.send("form-type", @args.formType)
            if !@args.options.nil? && @args.options.length > 0
              child.children do |children|
                @args.options.each do |option|
                  option_model = Mio::Model::MetadataDefinition::Option.new @client, OpenStruct.new(option)
                  option_model.build_xml children
                end
              end
            end
            if !@args.strings.nil? && @args.strings.length > 0
              child.children do |children|
                @args.strings.each do |string|
                  definition = Mio::Model::MetadataDefinition::Definition.new @client, OpenStruct.new(string)
                  definition.build_xml children, 'string'
                end
              end
            end
          end
        end

        def multiple_identical_options key
          hash_count = @args.options.each_with_object(Hash.new(0)) { |option, count| count[option[key.to_sym]] += 1 }
          error_msg = ''
          hash_count.each do |key, count|
            if count > 1
              error_msg += error_msg == '' ? "#{key} occurs #{count} times" : ", #{key} occurs #{count} times"
            end
          end
          unless error_msg == ''
            raise Mio::Model::DataValueError, "Multiple identical options not allowed [" + error_msg + "]"
          end
        end

        def boolean_option_check
          if @args.type == 'boolean'
            @args.options.each do |option|
              unless option[:name] =~ /^(true|false)$/
                raise Mio::Model::DataValueError, "Boolean option name must be true|false"
              end
              unless option[:value] =~ /^(true|false)$/
                raise Mio::Model::DataValueError, "Boolean option value must be true|false"
              end
              if option[:name] == 'true' && option[:value] != 'true'
                raise Mio::Model::DataValueError, "true option name must have true option value"
              end
              if option[:name] == 'false' && option[:value] != 'false'
                raise Mio::Model::DataValueError, "false option name must have false option value"
              end
            end
          end
        end

        def validate
          super
          multiple_identical_options 'name'
          multiple_identical_options 'value'
          boolean_option_check
          true
        end
        alias_method :valid?, :validate

      end
    end
  end
end
