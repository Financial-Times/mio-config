class Mio
  class Model
    class S3 < Model
      set_resource :resources

      field :name, String, /^(?!\s*$).+/
      field :visibility, Array
      field :key, String
      field :secret, String
      field :bucket, String

      field :enable, Symbol
      field :start, Symbol

      def create_array
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource'

        {name: @args.name,
        pluginClass: plugin,
        visibilityIds: @args.visibility}
      end

      def config_array
        {
          'vfs-location' => {
            protocol: "S3",
            path: "/",
            key: @args.fetch('key'),
            secret: @args.secret,
            bucket: @args.bucket
          }
        }
      end

    end
  end
end
