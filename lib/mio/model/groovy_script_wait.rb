class Mio
  class Model
    class GroovyScriptWait < Model
      set_resource :actions

      field :name, String, 'Script name'
      field :displayName, String, 'Script Display name'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :script, String, 'The groovy script (inline) ', '"File.read(/path/to/script.groovy)"'
      field :jars, Array, 'JARs to load on remote, empty for none', []
      field :imports, Array, 'Imports to reference within groovy script, empty for none', []
      field :timeout, Fixnum, 'Time to give up waiting', 0
      field :polling_time, Fixnum, 'Time to wait between script invocation', 100000
      field :requiresLock, String, 'Requires asset Lock', 'EXCLUSIVE', /^(NONE|EXCLUSIVE|SHARED)$/

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
        {"script_type": {
         "script": @args.script
        },
        "imports": {
          'jar-url': @args.jars.map{|j| {value: j, isExpression: false}},
          import: @args.imports.map{|i| {value: i, isExpression: false}}
        },
        "timeout": @args.timeout,
        "polling-time-period": @args.polling_time,
        "requires-lock": @args.requiresLock
        }
      end
    end
  end
end
