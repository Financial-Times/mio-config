class Mio
  class Model
    class << self
      attr_accessor :fields
      def resource resource
        @resource = resource
      end

      def field key, type, matcher=nil
        @fields ||= []
        @fields << {name: key,
                    type: type,
                    matcher: matcher}
      end
    end

    def initialize client, args={}
      @client = client
      @args = args
    end

    def create
      @client.create self.class.resource.to_s, @args
    end

    def validate
      testable = @args.dup

      self.class.fields.each do |f|
        unless testable.key? f[:name]
          raise Mio::Model::MissingField, "Missing field #{f[:name]} to #{self}"
        end

        extracted_field = testable.delete f[:name]
        unless extracted_field.is_a? f[:type]
          raise Mio::Model::DataTyoeError, "#{f[:name]} should be of type #{f[:type]} for #{self}"
        end

        unless f[:matcher].nil? or extracted_field.to_s.match(f[:matcher])
          raise Mio::Model::DataValueError, "#{self} #{f[:name]} value '#{extracted_field}' does not match #{f[:matcher]}"
        end
        true
      end

      testable.keys.each do |k|
        raise Mio::Model::NoSuchField, "#{k} for #{self}"
      end
    end
    alias_method :valid?, :validate

  end
end
