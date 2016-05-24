require 'nokogiri'

class Mio
  class Model
    class MetadataDefinition < Model
      set_resource :metadataDefinitions

      field :name, String, 'Name of the metadata definition'
      field :displayName, String, 'Display name'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :searchable, Symbol, 'Searchable metadata'
      field :required, Symbol, 'Required Metadata'
      field :editable, Symbol, 'Editable within the workflow tool'
      field :definitions, Array, 'List of definitions'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        {name: @args.name,
        visibilityIds: @args.visibility}
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
          else
            ''
        end
      end

      def build_options_xml children, hash
        children.send("option-child", name: hash.fetch(:name),
                    default: hash.fetch(:default),
                    value: hash.fetch(:value),
                    display_name: hash.fetch(:displayName));
      end

      def build_children_xml children, hash, type=nil
        if type.nil?
          type = hash.fetch(:type)
        end
        children.send(type+'_', name: hash.fetch(:name), display_name: hash.fetch(:displayName)) do |child|
          child.searchable hash.fetch(:searchable).to_s
          child.editable hash.fetch(:editable).to_s
          child.required hash.fetch(:required)
          if hash.key?(:maxLength)
            max_length = hash.fetch(:maxLength)
            unless max_length.nil? && max_length.equal?(-1)
              child.send("max-length", max_length )
            end
          end
          if hash.key?(:validationHandler)
            validation_handler = hash.fetch(:validationHandler)
            unless validation_handler.nil?
              child.validation handler: validation_handler
            else
              child.validation handler: validation_handler_by_type(type)
            end
          end
          if hash.key?(:formType)
            child.send("form-type", hash.fetch(:formType))
          end
          if hash.key?(:options)
            options = hash.fetch(:options)
            unless options.nil? && options.length > 0
              child.children do |children|
                options.each do |option|
                  build_options_xml children, option
                end
              end
            end
          end
          if hash.key?(:strings)
            strings = hash.fetch(:strings)
            unless strings.nil? && strings.length > 0
              child.children do |children|
                strings.each do |string|
                  build_children_xml children, string, 'string'
                end
              end
            end
          end
        end
      end

      def definition_xml
        xml_builder = Nokogiri::XML::Builder.new do |xml|
          xml.metadata(name: @args.name ) {
            xml.searchable @args.searchable.to_s
            xml.editable @args.editable.to_s
            xml.required @args.required.to_s
            xml.children do |children|
              @args.definitions.each do |definition|
                build_children_xml children, definition
              end
            end
          }
        end
        xml_builder.to_xml
      end

      def go
        if @args.definitions.empty?
          raise Mio::Model::EmptyField, 'Field definitions to Mio::Model::MetadataDefinition must contain at least one definition'
        end

        unless look_up
          @object = create
        else
          @object = look_up
          set_start :stop
        end
        definition_path = "#{self.class.resource_name}/#{@object['id']}/definition"

        @client.definition definition_path, definition_xml

        set_enable
        return @object
      end

    end
  end
end

