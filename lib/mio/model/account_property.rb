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

      def look_up
        r = self.class.resource_name
        all_resources = @client.find_all r
        return nil if all_resources['totalCount'] == 0

        all_resources[r].find{|o| o['key'] == @args.key}
      end

      def go
        @object = look_up
        if @object.nil?
          @object = create
        elsif  ((@object != nil) && (@object['value'] != @args.value))
          @client.remove self.class.resource_name, @object['id']
          @object = create
        end

        @object['name'] = @args.name
        @object['id'] = @object['href'].scan( /\d+$/).last

        return @object
      end

    end
  end
end
