namespace :mio do
  namespace :migrate do
    desc 'Create a new migration'
    task :create, [:model, :desc] do |t,args|
      config = Mio::Config.read File.expand_path './config/mio.yml'
      migrater = Mio::Migrations.new(config.base_url,
                                     config.username,
                                     config.password )

      model = args.model
      raise Mio::Model::NoSuchResource, "#{model} is an invalid mode" if model.nil?

      File.open(migrater.create_migration_file(args.desc), 'w') do |mig|
        mig.puts "migration '#{args.desc}' do"
        mig.puts "  #{model.to_s} do |m|"

        Mio::Model.mappings[model.to_s].fields.each do |f|
          mig.puts "    m.#{f[:name]} = #{f[:type]}"
        end
        mig.puts "  end"
        mig.puts "end"
      end
    end
  end
end
