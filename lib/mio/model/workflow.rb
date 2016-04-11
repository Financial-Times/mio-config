class Mio
  class Model
    class Workflow < Model
      set_resource :workflows

      field :name, String, 'Name of the S3 resource'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :nodes, Array, 'List of nodes'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        {name: @args.name,
         visibilityIds: @args.visibility}
      end

    end
  end
end
