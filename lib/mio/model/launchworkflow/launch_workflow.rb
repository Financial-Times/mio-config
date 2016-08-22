class Mio
  class Model
    class LaunchWorkflowAction
      class LaunchWorkflow < Model
        set_resource :actions

        field :name, String, 'Name of the workflow to launch'
        field :inheritVariables, Symbol, 'Inherit variables from calling workflow'
        field :workFlowStringVariables, Array, ''
        field :workFlowObjectVariables, Array, ''
        field :workflowDateVariables, Array, ''

        nested true

        def create_hash
          workflow_definition = @search.find_workflowDefinitions_by_name(@args.name).first
          if workflow_definition.nil?
            raise Mio::Model::NoSuchResource, 'No such workflowDefinition [' + @args.name + ']'
          end

          {Workflow: { id:  workflow_definition['id']},
           'inherit-variables': @args.inheritVariables,
           'workflow-string-variable': @args.workFlowStringVariables,
           'workflow-object-variable': @args.workFlowObjectVariables,
           'workflow-date-variable': @args.workflowDateVariables
          }
        end

      end
    end
  end
end