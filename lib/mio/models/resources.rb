class Mio
  class Models
    class Resources < Base
      resource :resources

      field :name, String, /^(?!\s*$).+/
      field :visibility, Array
      field :type, Symbol

      def create
        # Override create from Mio::Models::Base
        type = {
          vfs: 'tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource'
        }[@args[:type]]

        @client.create 'resources',
                       {name: @args[:name],
                        pluginClass: type,
                        visibilityIds: @args[:visibility]}
      end

    end
  end
end
