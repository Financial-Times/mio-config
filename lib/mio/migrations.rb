require 'mio'
require 'colorize'
require 'mio/config'

class Mio
  class Migrations
    def initialize base_uri, username, password, verify_ssl, base_dir='./migrations'
      @mio = Mio.new do |m|
        m.base_uri = base_uri
        m.username = username
        m.password = password
        m.verify_ssl = verify_ssl
      end
      @base = File.expand_path(base_dir)
      @migrations = Dir.glob( File.join(@base, '*.rb') ).sort
    end

    def create_migration_file desc
      File.join(@base,
                "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{desc.gsub(/\W/, '-')}.rb")
    end

    def run_migrations
      @migrations.each do |migration|
        unless has_run? migration
          load_migration migration
        end
      end
    end

    def has_run? migration
      false
    end

    def load_migration migration
      eval File.read(migration)
    end

    # Helper methods for within the migrations
    def migrate desc, &block
      msg desc, 'starting'
      block.call

      msg desc, 'completed'
    end

    def type_migration klass, conf
      if klass.nested?
        get_it klass.new(@mio.client, conf)
      else
        do_it klass.new(@mio.client, conf)
      end
    end

    def method_missing method_sym, *arguments, &block
      mapped = Mio::Model.mappings[method_sym.to_s]

      if mapped.nil?
        super
      else
        conf = OpenStruct.new
        yield conf
        type_migration mapped, conf
      end
    end

    def respond_to? method_sym, include_private=false
      if Mio::Model.mappings[method_sym.to_s].nil?
        super
      else
        true
      end
    end

    private
    def do_it thing
      if thing.valid?
        obj = thing.go
      end
      puts "Created '#{obj['name']}' with id '#{obj['id']}'"
    end

    def get_it thing
      if thing.valid?
        return thing.create_hash
      end
      return nil
    end


    def msg desc, state
      print '======> '.magenta
      print "#{desc}:\t".cyan
      puts "#{state.upcase}".magenta
    end
  end
end
