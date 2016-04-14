class Mio
  class Model
    class Workflow
      class Node < Model
        set_resource :workflows

        field :name, String, 'Nodal Name'
        field :action, String, 'Name of the action, empty for none', 'Load S3'
        field :type, String, 'Action Type', 'ACTION'

        nested true

        def create_hash
          h = {name: @args.name,
               path: "/#{@args.path}",
               type: @args.type.upcase,
              }
          if @args.type.upcase == 'ACTION'
            action = @search.find_actions_by_name(@args.action).first
            h[:action] = normalize_action action

          end
          h
        end

        def normalize_action a
          {id: a['id'],
           name: a['name'],
           pluginClass: a['pluginClass']}
        end

      end
    end
  end
end
