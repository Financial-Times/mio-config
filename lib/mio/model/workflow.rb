class Mio
  class Model
    class Workflow < Model
      set_resource :workflowDefinitions

      field :name, String, 'Name of the S3 resource'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :transitions, Array, 'List of transitions'
      field :nodes, Array, 'List of nodes'

      field :enable, Symbol, ':true or :false', :true

      def create_hash
        {name: @args.name,
         visibilityIds: @args.visibility}
      end

      def normalize_node n
        {
          id: n['id'],
          name: n['name'],
          path: n['path']
        }
      end

      def set_node_layouts
        x = @spacing
        y = @spacing

        @args.nodes.map do |n|
          n[:layout] = {
            width: @icon_width,
            height: @icon_height,
            x: x,
            y: y
          }
          x += (@icon_width + @spacing)
          if x > @width - (@icon_width + @spacing)
            x = 0
            y += (@icon_height + @spacing)
          end
          n
        end
      end

      def transition_lookup structure
        @args.transitions.map do |t|
          from = structure['nodes'].find{|n| n['name'] == t[:from]}
          to = structure['nodes'].find{|n| n['name'] == t[:to]}

          raise Mio::Model::DataValueError, "#{t[:from]} to #{t[:to]} is an invalid transition" if from.nil? or to.nil?

          { name: t[:name],
            from: normalize_node(from),
            to: normalize_node(to)}
        end
      end

      def structure_hash nodes, transitions=[]
        {nodes: nodes,
         transitions: transitions,
         width: @width,
         height: @height}
      end

      def go
        if @args.nodes.empty? or @args.transitions.empty?
          raise Mio::Model::EmptyField, 'Field nodes to Mio::Model::Workflow must contain at least one node and one transition'
        end

        @width = 900
        @height = 1024
        @icon_width = 120
        @icon_height = 45
        @spacing = 100

        unless look_up
          @object = create
        else
          @object = look_up
          set_start :stop
        end
        @structure_path = "#{self.class.resource_name}/#{@object['id']}/structure"

        laid_out_nodes = set_node_layouts
        # Create structure minus transitions
        structure = @client.update @structure_path, structure_hash(laid_out_nodes)

        # Create structre with transitions
        @client.update @structure_path, structure_hash(laid_out_nodes,  transition_lookup(structure))

        set_enable
        return @object
      end

    end
  end
end
