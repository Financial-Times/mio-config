class Mio
  class Search
    def initialize client
      @client = client
    end

    def all resource, key, value
      @client.find_all(resource)[resource].select{|o| o.method(key).call == value}
    end

    def method_missing(method_sym, *arguments, &block)
      # the first argument is a Symbol, so you need to_s it if you want to pattern match
      if method_sym.to_s =~ /^find_(.*)_by_(.*)$/
        all($1, $2, arguments.first)
      else
        super
      end
    end

    def respond_to?(method_sym, include_private = false)
      if method_sym.to_s =~ /^find_(.*)_by_(.*)$/
        true
      else
        super
      end
    end

  end
end
