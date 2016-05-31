class Mio
  class Model
    class MessageTemplate < Model
      set_resource :messageTemplates

      field :name, String, 'Name of the Email Message Action'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :subject, String, 'Subject of email'
      field :priority, String, 'Email Priority - Highest, High, Normal, Low, Lowest', 'Normal'
      field :template, String, 'Email template HTML'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        {name: @args.name,
         visibilityIds: @args.visibility,
         subject: @args.subject,
         priority: @args.priority
        }
      end

      def go
        unless look_up
          @object = create
        else
          @object = look_up
          set_start :stop
        end
        template_path = "#{self.class.resource_name}/#{@object['id']}/body"

        @client.template template_path, @args.template

        set_enable
        return @object
      end

    end
  end
end
