Gem::Specification.new do |s|
  s.name = "mio-config"
  s.version = "2.2.0"
  s.license = 'MIT'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jspc","jemrayfield"]
  s.date = "2016-04-29"
  s.description = "Configure MIO"
  s.summary = "Financial Times MIO mangler"
  s.email = "james.condron@ft.com, jem.rayfield@ft.com"
  s.homepage = "https://ft.com"
  s.extra_rdoc_files = [
    "README.md"

  ]
  s.files = ["./lib/mio/client.rb", "./lib/mio/config.rb", "./lib/mio/errors.rb", "./lib/mio/migrations.rb", "./lib/mio/model/autoload.rb", "./lib/mio/model/create_place_holder_group_asset.rb", "./lib/mio/model/groovy_script.rb", "./lib/mio/model/groovy_script_wait.rb", "./lib/mio/model/hotfolder.rb", "./lib/mio/model/import_action.rb", "./lib/mio/model/metadata_definition.rb", "./lib/mio/model/metadatadefinition/definition.rb", "./lib/mio/model/metadatadefinition/option.rb", "./lib/mio/model/s3.rb", "./lib/mio/model/variant.rb", "./lib/mio/model/workflow/node.rb", "./lib/mio/model/workflow/transition.rb", "./lib/mio/model/workflow.rb", "./lib/mio/model.rb", "./lib/mio/requests.rb", "./lib/mio/search.rb", "./lib/mio/tasks/migrations.rb", "./lib/mio/tasks/skeletons.rb", "./lib/mio/tasks.rb", "./lib/mio.rb"] 
  s.add_dependency('builder')
  s.add_dependency('colorize', '~>0.7')
  s.add_dependency('faraday', '~>0.9')
  s.add_dependency('faraday-detailed_logger', '~>1.0')
  s.add_dependency('net-http-persistent', '~>2.9')
  s.add_dependency('rake', '~>0')
end
