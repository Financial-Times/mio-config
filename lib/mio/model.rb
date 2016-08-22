class Mio
  class Model
    attr_reader :args, :search, :client
    class << self
      attr_accessor :fields, :resource_name
      def set_resource r
        @resource_name = r.to_s
      end

      def field key, type, desc, default=nil, matcher=nil
        @fields ||= []
        @fields << {name: key,
                    type: type,
                    default: default,
                    matcher: matcher,
                    desc: desc,}

      end

      def nested val=nil
        if val.nil?
          @nested_value || false
        else
          @nested_value = val
        end
      end
      alias_method :nested?, :nested

      def mappings
        m = {}
        ObjectSpace.each_object(Class).each do |k|
          if k < Mio::Model
            m[ k.to_s.split('::').last.downcase ] = k
          end
        end
        m
      end
    end

    def initialize client, args
      @client = client
      @args   = args
      @search = Mio::Search.new @client
    end

    def go
      unless look_up
        @object = create
      else
        @object = look_up

        # We can't edit a running resource
        set_start :stop
      end

      configure if self.respond_to? :config_hash
      set_enable
      set_start

      return @object
    end

    def create
      @client.create self.class.resource_name, create_hash
    end

    def configure
      @client.configure self.class.resource_name,
                        @object['id'],
                        config_hash
    end

    def set_enable a=nil
      if a.nil?
        action = @args.enable == :true ? 'enable' : 'disable'
      else
        action = a.to_s
      end
      @client.action self.class.resource_name,
                     @object['id'],
                     {action: action}
    end
    alias_method :disable!, :set_enable
    alias_method :enable!, :set_enable

    def set_start a=nil
      if a.nil?
        action = @args.start == :true ? 'start' : 'stop'
      else
        action = a.to_s
      end
      @client.action self.class.resource_name,
                     @object['id'],
                     {action: action}
    end
    alias_method :stop!, :set_start
    alias_method :start!, :set_start

    def validate
      testable = self.args.dup.to_h

      self.class.fields.each do |f|
        unless testable.key? f[:name]
          raise Mio::Model::MissingField, "Missing field #{f[:name]} to #{self}"
        end

        extracted_field = testable.delete f[:name]
        unless extracted_field.is_a? f[:type]
          raise Mio::Model::DataTypeError, "#{f[:name]} should be of type #{f[:type]} for #{self}"
        end

        #unless f[:matcher].nil? or extracted_field.to_s.match(f[:matcher])
        if !f[:matcher].nil? && extracted_field.to_s.match(f[:matcher]).nil?
          raise Mio::Model::DataValueError, "#{self} #{f[:name]} value '#{extracted_field}' does not match #{f[:matcher]}"
        end
      end

      testable.keys.each do |k|
        raise Mio::Model::NoSuchField, "#{k} for #{self}"
      end
      true
    end
    alias_method :valid?, :validate

    private
    def look_up
      r = self.class.resource_name
      all_resources = @client.find_all r
      return nil if all_resources['totalCount'] == 0

      all_resources[r].find{|o| o['name'] == @args.name}
    end
  end

end
