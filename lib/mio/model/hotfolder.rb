class Mio
  class Model
    class Hotfolder < Model
      set_resource :resources

      field :storage_resource_name, String
      field :workflow_name, String
      field :owner, String

      field :name, String, /^(?!\s*$).+/
      field :visibility, Array

      field :enable, Symbol
      field :start, Symbol

      def create_array
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.folder.hotfolder.MioHotFolderResource'

        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility}
      end

      def config_array
        # Get the s3 resource id
        storage = @search.find_resources_by_name(@args.storage_resource_name).first
        raise Mio::Model::NoSuchResource, "Could not find #{@args.storage_resource_name}" unless storage

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
              {'id' =>  storage.id }
            ]
          },
          'use-md5' => false,
          'workflow-definition' => {
            'id' =>  workflow.id
          },
          'owner' => {
            'id' =>  owner.id
          }
        }
      end

    end
  end
end
