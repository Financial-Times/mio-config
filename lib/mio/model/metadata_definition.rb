require 'nokogiri'

class Mio
  class Model
    class MetadataDefinition < Model
      set_resource :metadataDefinitions

      field :name, String, 'Name of the metadata definition'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :displayName, String, 'Display name'
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

      def build_xml
        xml_builder = Nokogiri::XML::Builder.new do |xml|
          xml.metadata(name: @args.name ) {
            xml.searchable @args.searchable.to_s
            xml.editable @args.editable.to_s
            xml.required @args.required.to_s
            xml.children do |children|
              @args.definitions.each do |defs|
                definition = Mio::Model::MetadataDefinition::Definition.new @client, OpenStruct.new(defs)
                definition.build_xml children
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

        @client.definition definition_path, build_xml

        set_enable
        return @object
      end

    end
  end
end

