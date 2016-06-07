class Mio
  class Model
    class ImportAction < Model
      set_resource :actions
      field :name, String, 'Name of the Import Action'
      field :key, String, 'AWS API Key with access to S3'
      field :secret, String, 'AWS secret'
      field :bucket, String, 'AWS bucket name'
      field :variant, String, 'Variant name'
      field :metadataDefinition, String, 'Metadata definition id'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :sourceJsonVariable, String, 'Json Variable to grab metadata from'

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

      def metadata_definition_id metadata_definition_name
        r = 'metadataDefinitions'
        metadata_definitions = @client.find_all(r)

        md = metadata_definitions[r].find{|md| md['name'] == metadata_definition_name}
        if md.nil?
          raise Mio::Model::NoSuchResource, 'No such metadata definition[' + metadata_definition_name + ']'
        end

        md['id']
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
          },
          "variant-and-metadata-definition": {
            "variant": {
              "value": @args.variant,
              "isExpression": false
            },
            "metadata": {
              "metadata-definition": {
                "id": metadata_definition_id(@args.metadataDefinition)
              },
              "source-json-variable": {
                "value": @args.sourceJsonVariable,
                "isExpression": false
              }
            }
          }
        }
      end
    end
  end
end
