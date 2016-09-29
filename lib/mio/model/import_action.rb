class Mio
  class Model
    class ImportAction < Model
      set_resource :actions
      field :name, String, 'Name of the Import Action'
      field :key, String, 'AWS API Key with access to S3'
      field :secret, String, 'AWS secret'
      field :bucket, String, 'AWS bucket name'
      field :variant, String, 'Variant name'
      field :creationContext, String, 'Creation Context', 'Ingest', /^(INGEST|PROXY|COPY|TRANSCODE|IMPORT|TRANSFORM)$/
      field :parentAssetId, String, 'Variable or Id for parent Asset to associate', ''
      field :parentRelationName, String, 'Name of parent child relationship', ''
      field :s3PathVariable, String, 'S3 Path variable', '${variables.assetS3Path}'
      field :assetTitleVariable, String, 'S3 asset title variable', '${variables.assetTitle}'
      field :metadataDefinition, String, 'Metadata definition id'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :sourceJsonVariable, String, 'Json Variable to grab metadata from'
      field :runRuleExpression, String, 'Job run rule expression', ''

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.objectimport.vfs.AssetImportCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'import',
         'runRuleExpression': @args.runRuleExpression
        }
      end

      def config_hash
        metadata_definition = @search.find_metadataDefinitions_by_name(@args.metadataDefinition).first
        if metadata_definition.nil?
          raise Mio::Model::NoSuchResource, 'No such metadata definition [' + @args.metadataDefinition + ']'
        end

        h = {
          "source-file": {
            "source": {
              "vfs-source-file-path": {
                "protocol": {
                  "value": "S3",
                  "isExpression": false
                },
                "path": {
                  "value": @args.s3PathVariable,
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
              "value": @args.assetTitleVariable,
              "isExpression": false

            },
            "asset-origin": {
              "value": @args.creationContext,
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
                "id": metadata_definition['id']
              },
              "source-json-variable": {
                "value": @args.sourceJsonVariable,
                "isExpression": false
              }
            }
          }
        }
        unless @args.parentAssetId.to_s == ''
          h["asset-relationships"] = {
              "child": {
                "parent": {
                    "parent-asset-id": {
                        "value": @args.parentAssetId,
                        "isExpression": false
                    }
                },
                "reference-name": {
                    "value": @args.parentRelationName,
                    "isExpression": false
                }
              }
          }
        end

        h
      end
    end
  end
end
