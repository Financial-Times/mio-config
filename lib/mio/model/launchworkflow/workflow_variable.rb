class Mio
  class Model
    class LaunchWorkflowAction
      class WorkflowVariable < Model
        set_resource :actions

        field :key, String, 'Variable key'
        field :value, String, 'Variable value if type==date must be dd-MM-yy HH:mm:ss, if type==object must be numeric and exist as an asset'
        field :type, String, 'Key type or prefix', nil, /^(string|date|object)$/

        nested true

        def create_hash
          {@args.type+'-variable-key' => {value: @args.key, isExpression: false},
           @args.type+'-variable-value' => {value: @args.value, isExpression: false}
          }
        end

        def validate_date_value
          # Ensure value conforms to dd-MM-yyyy HH:mm:ss
          unless @args.value =~ /^(?:0?[1-9]|[1-2]\d|3[01])-(?:0?[1-9]|1[0-2])-\d{4}\s([0]?\d|1\d|2[0-3]):([0-5]\d):([0-5]\d)$/
            raise Mio::Model::DateVariableInvalid, 'Workflow variable of type date must conform to dd-MM-yy HH:mm:ss [' + @args.value + ']'
          end
        end

        def asset_by_id
          asset = @client.find 'assets', @args.value

          if asset[:status] == 404
            raise Mio::Model::NoSuchResource, 'No such asset [' + @args.value + ']'
          end
          @args.value
        end

        def validate_object_value
          unless @args.value =~ /^[0-9]*$/
            raise Mio::Model::ObjectVariableInvalid, 'Workflow variable of type object must be a number [' + @args.value + ']'
          end
          asset_by_id
        end

        def validate
          super
          if @args.type == 'date'
            validate_date_value
          end
          if @args.type == 'object'
            validate_object_value
          end

          true
        end
        alias_method :valid?, :validate

      end
    end
  end
end