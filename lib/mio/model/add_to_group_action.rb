class Mio
  class Model
    class AddToGroupAction < Model
      set_resource :actions

      field :name, String, 'Name of the Add To Group action'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :targetAssetId, String, 'Expression to resolve and gather Asset Id', '${parentId}'
      field :groupName, String, 'The group name'
      field :referenceNamePrefix, String, 'The reference prefix', '${asset.name}'
      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.group.GroupManipulationCommand'

        {name: @args.name,
         pluginClass: plugin,
         type: 'add-to-group',
         visibilityIds: @args.visibility}
      end

      def config_hash
        h = {}
        unless @args.targetAssetId.to_s == ''
          h['target-asset-id'] = @args.targetAssetId
        end
        unless @args.groupName.to_s == ''
         h['group-name'] =  @args.groupName
        end
        unless @args.referenceNamePrefix.to_s == ''
          h['reference-name-prefix'] = @args.referenceNamePrefix
        end

        h
      end

    end
  end
end