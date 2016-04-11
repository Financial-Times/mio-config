class Mio
  class Model
    class Workflow
      class Node < Model
        set_resource :workflows

        field :name, String, 'Nodal Name'
        field :path, String, 'Path of node', '/Start'

        nested true

        def create_hash
          {name: @args.name,
           path: @args.path}
        end

      end
    end
  end
end
