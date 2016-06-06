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

      def get_message_template_id mesage_template_name
        r = 'messageTemplates'
        message_templates = @client.find_all(r)

        md = message_templates[r].find{|md| md['name'] == mesage_template_name}
        if md.nil?
          raise Mio::Model::NoSuchResource, 'No such message template [' + mesage_template_name + ']'
        end

        md['id']
      end

      def config_hash
        { 'message-template': { id: get_message_template_id(@args.template) },
          recipients: { expression: [ { value: @args.recipientExpression, isExpression: false } ] }
        }
      end

    end
  end
end
