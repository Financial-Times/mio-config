Gem::Specification.new do |s|
  s.name = "mio-config"
  s.version = "2.0.1"
  s.license = 'MIT'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jspc","jemrayfield"]
  s.date = "2016-04-29"
  s.description = "Configure MIO"
  s.summary = "Financial Times MIO mangler"
  s.email = "james.condron@ft.com"
  s.homepage = "https://ft.com"
  s.extra_rdoc_files = [
    "README.md"

  ]
  s.files = Dir.glob('./**/*')

  s.add_dependency('rake', '~>0')
  s.add_dependency('faraday', '~>0.9')
  s.add_dependency('net-http-persistent', '~>2.9')
  s.add_dependency('hashie', '~>3.4')
  s.add_dependency('colorize', '~>0.7')
end
