require 'mio'
require 'colorize'
require 'mio/config'

class Mio
  class Migrations
    def initialize base_uri, username, password, base_dir='./migrations'
      @mio = Mio.new do |m|
        m.base_uri = base_uri
        m.username = username
        m.password = password
      end
      @migrations = Dir.glob( File.join( File.expand_path(base_dir), '*.rb') )
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
      do_it klass.new(@mio.client, conf)
    end

    def method_missing method_sym, *arguments, &block
      mapped = model_mappings[method_sym.to_s]

      if mapped.nil?
        super
      else
        conf = Hashie::Mash.new
        yield conf
        type_migration mapped, conf
      end
    end

    def respond_to? method_sym, include_private=false
      if model_mappings[method_sym.to_s].nil?
        super
      else
        true
      end
    end

    private
    def model_mappings
      m = {}
      ObjectSpace.each_object(Class).each do |k|
        if k < Mio::Model
          m[ k.to_s.split('::').last.downcase ] = k
        end
      end
      m
    end

    def do_it thing
      if thing.valid?
        obj = thing.go
      end
      puts "Created '#{obj.name}' with id '#{obj.id}'"
    end


    def msg desc, state
      print '======> '.magenta
      print "#{desc}:\t".cyan
      puts "#{state.upcase}".magenta
    end
  end
end

namespace :mio do
  desc 'Handle migrations (via mio:migrate:up)'
  task :migrate do
    Rake::Task['mio:migrate:up'].invoke
  end

  namespace :migrate do
    desc 'Run migrations'
    task :up do
      config = Mio::Config.read File.expand_path './config/mio.yml'
      migrater = Mio::Migrations.new(config.base_url,
                                     config.username,
                                     config.password )
      migrater.run_migrations
    end
  end
end
