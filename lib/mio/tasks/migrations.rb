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
                                     config.password,
                                     config.verify_ssl )
      migrater.run_migrations
    end
  end
end
