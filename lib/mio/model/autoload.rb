Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |file|
  require File.join('mio', 'model', File.basename(file, File.extname(file)))
end
