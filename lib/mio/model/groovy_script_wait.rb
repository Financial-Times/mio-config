class Mio
  class Model
    class GroovyScriptWait < Model
      set_resource :actions

      field :name, String, 'Script name'
      field :displayName, String, 'Script Display name'
      field :key, String, 'AWS API Key with access to S3'
      field :secret, String, 'AWS secret'
      field :visibility, Array, 'Ids of the accounts which may see the import action' 
      field :script, String, 'The groovy script (inline) ', '"File.read(/path/to/script.groovy)"'
      field :jars, Array, 'JARs to load on remote, empty for none', [] 
      field :imports, Array, 'Imports to reference within groovy script, empty for none', []
      field :timeout, Integer, 'Time to give up waiting', 0
      field :pollingTime, Integer, 'Time to wait between script invocation', 100000

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.plugins.actions.wait.ScriptedWaitCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         type: 'script',
         runRuleExpression: ''
        }
      end

      def config_hash
        {"script_type": 
         {"script": "def execute() {}"},
         "imports": {
          'jar-url': @args.jars.map{|jar| {value: jar, isExpression: false}},
          import: @args.imports.map{|import| {value: import, isExpression: false}}
        },
        "timeout": @args.timeout,
        "polling-time-period": @args.pollingTime
        }
      end
    end
  end
end
