class Mio
  class Model
    class S3 < Model
      set_resource :resources

      field :name, String, 'Name of the S3 resource'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :key, String, 'AWS API Key with access to bucket'
      field :secret, String, 'Secret key associated to :key'
      field :bucket, String, 'Bucket with which to interact'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource'

        {name: @args.name,
        pluginClass: plugin,
        visibilityIds: @args.visibility}
      end

      def config_hash
        {
          'vfs-location' => {
            protocol: "S3",
            path: "/",
            key: @args['key'],
            secret: @args.secret,
            bucket: @args.bucket
          }
        }
      end

    end
  end
end
