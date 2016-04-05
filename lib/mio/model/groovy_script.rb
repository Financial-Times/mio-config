class Mio
  class Model
    class GroovyScript < Model
      set_resource :actions

      field :name, String, 'Script name'
      field :displayName, String, 'Script Display name'
      field :key, String, 'AWS API Key with access to S3'
      field :secret, String, 'AWS secret'
      field :visibility, Array, 'Ids of the accounts which may see the import action' 
      field :script, String, 'The groovy script (locally)'
      field :jar, String, 'JAR to load on remote, empty for none' 
      field :imports, Array, 'Imports to reference within groovy script, empty for none', []

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.plugins.actions.script.GroovyScriptCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         type: 'script',
         runRuleExpression: ''
        }
      end

      def import_array 
        result = Array.new
        @args.imports.each{|import| result.insert(-1, { "value": import, "isExpression": false })}
        result
      end

      def config_hash
        imports_array = import_array
        {'script-contents': {
          script: @args.script

        },
        imports: {
          'jar-url': [
            {
              value: @args.jar,
              isExpression: false
            }
          ],
          import: imports_array
        }
        } 
      end
    end
  end
end
