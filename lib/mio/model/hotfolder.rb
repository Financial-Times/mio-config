class Mio
  class Model
    class Hotfolder < Model
      resource :resources

      field :storage_resource_name, String
      field :workflow_name, String
      field :owner, String

      field :name, String, /^(?!\s*$).+/
      field :visibility, Array

      field :enable, Symbol
      field :start, Symbol

      def create
        # Get the s3 resource id
        storages = @client.find_all('resources')
        storage = storages.resources.find do |s|
          s.name == @args[:storage_resource_name]
        end
        unless storage
          raise Mio::Model::NoSuchResource, "Could not find #{@args[:storage_resource_name]}"
        end
        storage_id = storage.id

        # Get the workflow name
        workflows = @client.find_all('workflows')
        workflow = workflows.workflows.find do |s|
          s.name == @args[:workflow_name]
        end
        unless workflow
          raise Mio::Model::NoSuchResource, "Could not find #{@args[:workflow_name]}"
        end
        workflow_id = workflow.id

        # User ID
        owner_id = @client.find_all('users').users.find{|u| u.displayName == @args[:owner]}.id

        # Override create from Mio::Models::Base
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.folder.hotfolder.MioHotFolderResource'

        object = @client.create 'resources',
                                {name: @args[:name],
                                 pluginClass: plugin,
                                 visibilityIds: @args[:visibility]}
        configure_payload = {
          'housekeeping-period' => 5139767606400000000,
          'inactivity-timeout' => 30000000,
          'storage-resources' => {
            'Storage Resource' => [
              {'id' =>  storage_id }
            ]
          },
          'use-md5' => false,
          'workflow-definition' => {
            'id' =>  workflow_id
          },
          'owner' => {
            'id' =>  owner_id
          }
        }

        @client.configure 'resources',
                          object.id,
                          configure_payload

        # Can't start if disabled
        if @args[:enable] == :true or @args[:start] == :true
          @client.action 'resources',
                         object.id,
                         {action: 'enable'}
        end

        if @args[:start] == :true
          @client.action 'resources',
                         object.id,
                         {action: 'start'} if @args[:start]
        end
        object
      end

    end
  end
end
