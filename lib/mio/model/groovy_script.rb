class Mio
  class Model
    class GroovyScript < Model
      set_resource :actions

      field :name, String, 'Script name'
      field :script, String, 'Path to script (locally)'
      field :jars, Array, 'JARs to load on remote, emptyfor none', []
      field :classes, Array, 'Class to load on remote, empty for none', []
    end
  end
end
