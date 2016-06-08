class Mio
  class Model
    class EmailMessageAction < Model
      set_resource :actions

      field :name, String, 'Name of the Email Message Action'
      field :visibility, Array, 'Ids of the accounts which may see the import action', [4]
      field :template, String, 'Name of email template'
      field :recipientExpression, String, 'Evaluated Expression value which generates an email address', '${job.mioObject.owner.email}'

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
        template = @search.find_messageTemplates_by_name(@args.template).first
        if template.nil?
          raise Mio::Model::NoSuchResource, 'No such template [' + @args.template + ']'
        end

        { 'message-template': { id: template['id'] },
          recipients: { expression: [ { value: @args.recipientExpression, isExpression: false } ] }
        }
      end

    end
  end
end
