class Mio
  class Model
    class MetadataDefinition
      class Option < Model
        set_resource :metadatadefinition

        field :name, String, 'Metadata Definition Name'
        field :displayName, String, 'Metadata Definition Description'
        field :default, Symbol, 'Metadata type'
        field :value, String, 'Indexed and searchable',
        field :type, String, 'option type option-child|string'

        nested true

      end
    end
  end
end
