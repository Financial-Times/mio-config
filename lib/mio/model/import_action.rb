class Mio
  class Model
    class ImportAction < Model
      set_resource :actions
      field :name, String, 'Name of the Import Action'
      field :key, String, 'AWS API Key with access to S3'
      field :secret, String, 'AWS secret'
      field :bucket, String, 'AWS bucket name'
      field :visibility, Array, 'Ids of the accounts which may see the import action'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.objectimport.vfs.AssetImportCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'import',
         'runRuleExpression': ''
        }
      end

      def config_hash
        {
          "source-file": {
            "source": {
              "vfs-source-file-path": {
                "protocol": {
                  "value": "S3",
                  "isExpression": false
                },
                "path": {
                  "value": "/${variables.externalFileName}",
                  "isExpression": false
                },
                "key": {
                  "value": @args['key'],
                  "isExpression": false
                },
                "secret": {
                  "value":  @args.secret,
                  "isExpression": false
                },
                "bucket": {
                  "value": @args.bucket,
                  "isExpression": false

                }
              }
            },
            "keep-source-filename": false
          },
          "asset-details": {
            "title": {
              "value": "${variables.externalFilename}",
              "isExpression": false

            },
            "creation-context": {
              "value": "IMPORT",
              "isExpression": false
            }
          }
        }
      end
    end
  end
end
