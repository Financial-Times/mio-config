class Mio
  class Model
    class AccountProperty < Model
      set_resource :accountProperties

      field :name, String, 'Name of account property'
      field :key, String, 'Account property key'
      field :value, String,'Account property value'

      def create_hash
        {key: @args.key,
         value: @args.value}
      end

      def go
        unless look_up
          @object = create
        #else
        #  @object = look_up
        end

        # @TODO Update the account property??
        # Does not appear to support PUT ?
        # Will need raise feature with oooooyyyyyaaaallllllaaaa
        # No configure endpoint as no configuration

        @object['name'] = @args.name
        @object['id'] = @object['href'].scan( /\d+$/).last

        return @object
      end

    end
  end
end
