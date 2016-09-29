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
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.process.impl.createobject.CreateVFSPlaceholderAsset'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'create-object',
         'runRuleExpression': ''
        }
      end

      def config_hash
        metadata_definition = @search.find_metadataDefinitions_by_name(@args.metadataDefinition).first
        if metadata_definition.nil?
          raise Mio::Model::NoSuchResource, 'No such metadata definition [' + @args.metadataDefinition + ']'
        end

        {"name": @args.name,
         "asset-type": 'group-asset',
         "asset-origin": @args.creationContext,
         "variant-and-metadata": {"variant-name": @args.variantName,
                                  "metadata-details": {"metadata-definition": {"id": metadata_definition['id']}}
                                 }
        }
      end

    end
  end
end
