Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |file|
  require File.join('mio', 'model', File.basename(file, File.extname(file)))
end

Dir[File.join(File.dirname(__FILE__), 'workflow', '*.rb')].each do |file|
  require File.join('mio', 'model', 'workflow', File.basename(file, File.extname(file)))
end

Dir[File.join(File.dirname(__FILE__), 'metadatadefinition', '*.rb')].each do |file|
  require File.join('mio', 'model', 'metadatadefinition', File.basename(file, File.extname(file)))
end

Dir[File.join(File.dirname(__FILE__), 'launchworkflow', '*.rb')].each do |file|
  require File.join('mio', 'model', 'launchworkflow', File.basename(file, File.extname(file)))
end