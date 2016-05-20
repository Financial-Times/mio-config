class Mio
  class Model
    class MetadataDefinition
      class Definition < Model
        set_resource :metadatadefinition

        field :name, String, 'Metadata Definition Name', ''
        field :displayName, String, 'Display name'
        field :type, String, 'Metdata type text|single-option|checkbox|image', 'textarea'
        field :description, String, 'Metadata Definition Description', ''
        field :searchable, Symbol, 'Indexed and searchable', :true
        field :editable, Symbol, 'Editable field', :true
        field :required, Symbol, 'Required mandatory metadata item', :true
        field :formType, String, 'Form control type'
        field :maxLength, Fixnum, 'MaxLength', -1
        field :validationHandler, String, 'Validation handler', nil
        field :options, Array, 'Array of options', nil

        nested true

      end
    end
  end
end
