class Mio
  class Model
    class MetadataDefinition
      class Definition < Model
        set_resource :metadatadefinition

        field :name, String, 'Metadata Definition Name'
        field :description, String, 'Metadata Definition Description'
        field :type, String, 'Metadata type'
        field :searchable, Symbol, 'Indexed and searchable', :true
        field :editable, Symbol, 'Editable field', :true
        field :required, Symbol, 'Required mandatory metadata item', :true
        field :formType, String, 'Form control type'
        field :validationHandler, String, 'Validation handler', nil
        field :options, Array, 'Array of options', nil

        nested true

      end
    end
  end
end