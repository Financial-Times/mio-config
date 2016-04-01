namespace :mio do
  namespace :migrate do
    desc 'Create a new migration'
    task :create, [:model, :desc] do |t,args|
      config = Mio::Config.read File.expand_path './config/mio.yml'
      migrater = Mio::Migrations.new(config.base_url,
                                     config.username,
                                     config.password)

      model = args.model
      raise Mio::Model::NoSuchResource, "#{model} is an invalid mode" if model.nil?

      f = migrater.create_migration_file args.desc
      File.open(f, 'w') do |mig|
        mig.puts "migrate '#{args.desc}' do"
        mig.puts "  #{model.to_s} do |m|"

        Mio::Model.mappings[model.to_s].fields.each do |f|
          if f[:default].nil?
            value = f[:type]
          else
            case f[:type]
            when String
              value = "'#{f[:default]}'"
            else
              value = f[:default]
            end
          end
          mig.puts "    m.#{f[:name]} = #{value.inspect}"
        end
        mig.puts "  end"
        mig.puts "end"
      end

      puts f
    end
  end
end
