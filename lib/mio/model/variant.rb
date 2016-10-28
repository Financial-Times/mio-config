class Mio
  class Model
    class Variant < Model
      set_resource :variants

      field :name, String, 'Name of the Object Variant'
      field :objectType, String,'The Object which this varies', /^(group-asset|media-asset|text-asset)$/
      field :defaultVariant, Symbol, 'AWS API Key with access to bucket', :false
      field :metadataDefinitions, Array, 'Array of metadata definition names'
      field :defaultMetadataDefinition, String, 'Default metadata definition name'

      def metadata_definition_hash metadata_definitions
        r = 'metadataDefinitions'
        all_metadata_definitions = @client.find_all(r)
        return nil if all_metadata_definitions['totalCount'] == 0
        metadata_definitions_to_keep = []
        metadata_definitions.each do |metadata_definition|
          found_md = all_metadata_definitions[r].find{|md| md['name'] == metadata_definition}
          unless found_md.nil?
            metadata_definitions_to_keep << found_md
          end
        end

        {'md': metadata_definitions_to_keep}
      end

      def metadata_definition_id metadata_defintions, metadata_definition_name
        md = metadata_defintions[:md].find{|md| md['name'] == metadata_definition_name}
        if md.nil?
          raise Mio::Model::NoSuchResource, 'No such metadata definition[' + metadata_definition_name + ']'
        end

        md['id']
      end

      def metadata_definition_ids metadata_definitions, metadata_definition_names
        md_ids = []
        metadata_definition_names.each do |md_name|
          md_ids << metadata_definition_id(metadata_definitions, md_name)
        end

        md_ids
      end

      def create_hash
        metadata_definitions = metadata_definition_hash @args.metadataDefinitions

        object_type = @search.find_objectTypes_by_name(@args.objectType).first
        if object_type.nil?
          raise Mio::Model::NoSuchResource, 'No such object type [' + @args.objectType + ']'
        end

        h = {name: @args.name,
         objectTypeId: object_type['id'],
         defaultVariant: @args.defaultVariant}

        unless @args.metadataDefinitions.empty?
          h[:metadataDefinitionIds] = metadata_definition_ids(metadata_definitions, @args.metadataDefinitions)
          h[:defaultMetadataDefinition] = metadata_definition_id(metadata_definitions, @args.defaultMetadataDefinition)
        end

        h
      end

      def go
        if (@args.metadataDefinitions.empty? && (@args.objectType != 'text-asset'))
          raise Mio::Model::EmptyField, 'Field metadataDefinitions to Mio::Model::Variant contain at least one metadata definition name'
        end

        unless look_up
          @object = create
        else
          @object = look_up
        end

        return @object
      end

    end
  end
end
