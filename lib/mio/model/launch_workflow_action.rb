class Mio
  class Model
    class LaunchWorkflowAction < Model
      set_resource :actions

      field :name, String, 'Name of the Import Action'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :workflows, Array, 'Array of Launch Workflow configuration'
      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.launch.DefaultLaunchWorkflowCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         'type': 'launch',
         'runRuleExpression': ''
        }
      end

      def config_hash
        {workflows: @args.workflows
        }
      end

      def validate
        super
        if @args.workflows.empty?
          raise Mio::Model::EmptyField, 'Field workflows to Mio::Model::LaunchWorkflowAction must contain at least one launch workflow'
        end
      end

    end
  end
end