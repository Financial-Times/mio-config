class Mio
  class Model
    class MetadataDefinition
      class Option < Model
        set_resource :metadatadefinition

        field :name, String, 'Metadata Definition Name'
        field :displayName, String, 'Metadata Definition Description'
        field :default, Symbol, 'Metadata type'
        field :value, String, 'Indexed and searchable', :true

        nested true

      end
    end
  end
end