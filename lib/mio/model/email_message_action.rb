class Mio
  class Model
    class EmailMessageAction < Model
      set_resource :actions

      field :name, String, 'Name of the Email Message Action'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :template, Fixnum, 'Id of email template'
      field :recipientExpression, String, 'Evaluated Expression value which generates an email address', '${job.mioObject.owner.email}'

      # @TODO mio api does not currently support templates
      # templates CRUD needs to be automated via mio-config
      # templates should be looked up by name rather than by id ^^

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.process.impl.message.email.SendEmailMessageCommand'
        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility,
         type: 'message',
         runRuleExpression: ''
        }
      end

      def config_hash
        # @TODO Get the Email Template id from the template name

        { :'message-template' => { id: @args.template },
          recipients: { expression: [ { value: @args.recipientExpression, isExpression: false } ] }
        }
      end

    end
  end
end
