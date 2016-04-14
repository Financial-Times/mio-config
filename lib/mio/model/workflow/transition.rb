class Mio
 class Model
   class Workflow
     class Transition < Model
       set_resource :workflowDefinitions

       field :from, String, 'Starting node name'
       field :to, String,'Destination node name'

       nested true

       def create_hash
         {name: "from #{@args.from} to #{@args.to}",
          from: @args.from,
          to: @args.to}
       end
     end
   end
 end
end
