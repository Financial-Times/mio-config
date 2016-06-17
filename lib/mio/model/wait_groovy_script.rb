class Mio
  class Model
    class WaitGroovyScript < Model
      MIN_TIMEOUT_PERIOD = 10000
      MIN_POLLING_PERIOD = 10000

      set_resource :actions

      field :name, String, 'Script name'
      field :displayName, String, 'Script Display name'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :script, String, 'The groovy script (inline) ', '"File.read(/path/to/script.groovy)"'
      field :jars, Array, 'JARs to load on remote, empty for none', []
      field :imports, Array, 'Imports to reference within groovy script, empty for none', []
      field :timeout, Fixnum, 'Wait time out', 1000 * 60 * 60
      field :pollingTimePeriodMs, Fixnum, 'Time between script runs (polling time)', 1000 * 60

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.plugins.actions.wait.ScriptedWaitCommand'
        {name: @args.name,
         pluginClass: plugin,
         type: 'script',
         visibilityIds: @args.visibility,
         runRuleExpression: ''
        }
      end

      def config_hash
        {'script_type': {
          script: @args.script
        },
        imports: {
          'jar-url': @args.jars.map{|jar| {value: jar, isExpression: false}},
          import: @args.imports.map{|import| {value: import, isExpression: false}}
        },
        'timeout': @args.timeout,
        'polling-time-period': @args.pollingTimePeriodMs
        } 
      end

      def validate_timeout
        unless @args.timeout >= MIN_TIMEOUT_PERIOD
          raise Mio::Model::ObjectVariableInvalid, "Timeout period [#{@args.pollingTimePeriodMs}] must be greater or equal to [#{MIN_TIMEOUT_PERIOD}]"
        end
      end

      def validate_polling_time_period
        unless @args.pollingTimePeriodMs >= MIN_POLLING_PERIOD
          raise Mio::Model::ObjectVariableInvalid, "Polling period [#{@args.pollingTimePeriodMs}] must be greater or equal to [#{MIN_POLLING_PERIOD}]"
        end
      end

      def validate
        super
        validate_timeout
        validate_polling_time_period

        true
      end
      alias_method :valid?, :validate
    end
  end
end
