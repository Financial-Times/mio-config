class Mio
  class Model
    class PlaceHolderGroupAssetAction < Model
      set_resource :actions

      field :name, String, 'Name of the place holder asset'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :creationContext, String, 'Creation context', 'NEW'
      field :variantName, String, 'Object Variant to create', 'project-variant'
      field :metadataDefinition, String, 'The metadata definition name to associate to this place holder asset'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.process.impl.createobject.CreatePlaceholderAsset'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'create-object',
         'runRuleExpression': ''
        }
      end

      def metadata_definition_id metadata_definition_name
        r = 'metadataDefinitions'
        metadata_definitions = @client.find_all(r)

        md = metadata_definitions[r].find{|md| md['name'] == metadata_definition_name}
        if md.nil?
          raise Mio::Model::NoSuchResource, 'No such metadata definition[' + metadata_definition_name + ']'
        end

        md['id']
      end

      def config_hash
        {"name": @args.name,
         "asset-type": 'group-asset',
         "creation-context": @args.creationContext,
         "variant-and-metadata": {"variant-name": @args.variantName,
                                  "metadata-details": {"metadata-definition": {"id": metadata_definition_id(@args.metadataDefinition)}}
                                 }
        }
      end

    end
  end
end
