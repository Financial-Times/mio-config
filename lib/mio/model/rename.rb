class Mio
  class Model
    class Rename < Model
      set_resource :actions
      field :name, String, 'Name of the Import Action'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :runRuleExpression, String, 'Job run rule expression', ''
      field :preserveFileExtension, Symbol, 'preserve file extention of the file path', false
      field :filePath, String, 'File path', ''

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.rename.AssetRenameCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'rename',
         'runRuleExpression': @args.runRuleExpression
        }
      end

      def config_hash
        {
            "file": { "file-name": {  "value": @args.filePath,
                                      "isExpression": false
                                   },
                    "preserve-file-extension": @args.preserveFileExtension
                    }
        }
      end

    end
  end
end