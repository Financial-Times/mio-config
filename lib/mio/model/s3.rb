class Mio
  class Model
    class S3 < Model
      resource :resources

      field :name, String, /^(?!\s*$).+/
      field :visibility, Array
      field :key, String
      field :secret_key, String
      field :bucket, String

      field :enable, Symbol
      field :start, Symbol

      def create
        # Override create from Mio::Models::Base
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource'

        object = @client.create 'resources',
                                {name: @args[:name],
                                 pluginClass: plugin,
                                 visibilityIds: @args[:visibility]}
        configure_payload = {
          'vfs-location' => {
            protocol: "S3",
            path: "/",
            key: @args[:key],
            secret: @args[:secret_key],
            bucket: @args[:bucket]
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
