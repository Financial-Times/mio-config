class Mio
  class Model
    class Hotfolder < Model
      set_resource :resources

      field :storage_name, String, 'The name of the resource to be watched'
      field :workflow_name, String, 'The workflow this hotfolder kicks off'
      field :owner, String, 'The owner of the hotfolder', 'masteruser masteruser'

      field :name, String, 'Name of the hotfolder'
      field :visibility, Array, 'IDs of accounts that may see this', [4]

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false - :enable must be :true', :false

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.folder.hotfolder.MioHotFolderResource'

        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility}
      end

      def config_hash
        # Get the s3 resource id
        storage = @search.find_resources_by_name(@args.storage_name).first
        raise Mio::Model::NoSuchResource, "Could not find #{@args.storage_name}" unless storage

        # Get the workflow name
        workflow = @search.find_workflows_by_name(@args.workflow_name).first
        raise Mio::Model::NoSuchResource, "Could not find #{@args.workflow_name}" unless workflow

        owner = @search.find_users_by_displayName(@args.owner).first
        raise Mio::Model::NoSuchResource, "Could not find #{@args.owner}" unless owner

        {
          'housekeeping-period' => 5139767606400000000,
          'inactivity-timeout' => 30000000,
          'storage-resources' => {
            'Storage Resource' => [
              {'id' =>  storage['id'] }
            ]
          },
          'use-md5' => false,
          'workflow-definition' => {
            'id' =>  workflow['id']
          },
          'owner' => {
            'id' =>  owner['id']
          }
        }
      end

    end
  end
end
