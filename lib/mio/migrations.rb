require 'mio'
require 'colorize'

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

    def s3
      conf = Hashie::Mash.new
      yield conf

      s3_thing = Mio::Model::S3.new( @mio.client,
                                     name: conf.name,
                                     visibility: conf.visibility,
                                     # The below must be a fetch; #key is an instance method; can't call as above
                                     key: conf.fetch(:key),
                                     secret_key: conf.secret,
                                     bucket: conf.bucket,
                                     enable: conf.fetch(:enable, :false),
                                     start: conf.fetch(:start, :false) )

      if s3_thing.valid?
        obj = s3_thing.create
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
      migrater = Mio::Migrations.new(ENV.fetch('MIO_URI'),
                                     ENV.fetch('MIO_USERNAME'),
                                     ENV.fetch('MIO_PASSWORD'))
      migrater.run_migrations
    end
  end
end
