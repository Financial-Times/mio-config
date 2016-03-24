class Mio
  class Models
    class Base
      def initialize client, args={}
        @client = client
        @args = args
      end

      def create
        @client.create @@resource, @args
      end

      def validate
        testable = @args.dup

        @@fields.each do |f|
          unless testable.key? f[:name]
            raise Mio::Models::MissingField, "Missing field #{f[:name]} to #{self}"
          end

          extracted_field = testable.delete f[:name]
          unless extracted_field.is_a? f[:type]
            raise Mio::Models::DataTyoeError, "#{f[:name]} should be of type #{f[:type]} for #{self}"
          end

          unless f[:matcher].nil? or extracted_field.to_s.match(f[:matcher])
            raise Mio::Models::DataValueError, "#{self} #{f[:name]} value '#{extracted_field}' does not match #{f[:matcher]}"
          end
        end

        testable.keys.each do |k|
          raise Mio::Models::NoSuchField, "#{k} for #{self}"
        end
      end

      def self.field key, type, matcher=nil
        @@fields ||= []
        @@fields << {name: key,
                    type: type,
                    matcher: matcher}
      end

    end
  end
end
