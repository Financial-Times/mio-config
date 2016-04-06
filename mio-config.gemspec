Gem::Specification.new do |s|
  s.name = "mio-config"
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
    s.authors = ["jspc","jemrayfield"]
  s.date = "2016-03-30"
  s.description = "Configure MIO with lots of lovely shite"
  s.summary = "Financial Times MIO mangler"
  s.email = "james.condron@ft.com"
  s.homepage = "https://ft.com"
  s.extra_rdoc_files = [
    "README.md"

  ]
  s.files = Dir.glob('./**/*')

  s.add_dependency('rake')
  s.add_dependency('faraday')
  s.add_dependency('net-http-persistent')
  s.add_dependency('hashie')
  s.add_dependency('colorize')
end
