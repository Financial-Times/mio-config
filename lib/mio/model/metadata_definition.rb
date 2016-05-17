require 'builder'

class Mio
  class Model
    class MetadataDefinition < Model
      set_resource :metadataDefinitions

      field :name, String, 'Name of the metadata definition'
      field :displayName, String, 'Display name'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :searchable, Symbol, 'Searchable metadata'
      field :required, Symbol, 'Required Metadata'
      field :editable, Symbol, 'Editable within the workflow tool'
      field :definitions, Array, 'List of definitions'

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        {name: @args.name,
        visibilityIds: @args.visibility}
      end

      def trim_xml_from_element xml, endTag='</metadata>'
        endTagIdx = xml.index endTag
        if (endTagIdx)
          xmlEnd = endTagIdx + endTag.length
          if (xmlEnd < xml.length)
            xml = xml[0...-(xml.length-xmlEnd)]
          end
        end
        xml
      end

      def definition_xml
        builder = Builder::XmlMarkup.new
        builder.metadata name: @args.name do |metadata|
          metadata.searchable @args.searchable.to_s;
          metadata.editable @args.editable.to_s;
          metadata.required @args.required.to_s;
          metadata.children do |children|
             @args.definitions.each do |definition|
               case definition.fetch :formType
                 when "textarea"
                   children.text(name: definition.fetch(:name), display_name: @args.displayName)  do |text|
                     text.searchable definition.fetch(:searchable).to_s;
                     text.editable definition.fetch(:editable).to_s;
                     text.required definition.fetch(:required);
                     text.validation(handler: definition.fetch(:validationHandler));
                     text.tag! "form-type" do |x|
                       x.text! definition.fetch(:formType);
                     end
                   end
                 when "select"
                   children.tag!("single-option", name: definition.fetch(:name)) do |singleOption|
                     singleOption.searchable definition.fetch(:searchable).to_s;
                     singleOption.editable definition.fetch(:editable).to_s;
                     singleOption.required definition.fetch(:required);
                     singleOption.children do |children|
                       definition.fetch(:options).each do |option|
                         children.tag!("option-child", name: option.fetch(:name),
                                                       default: option.fetch(:default),
                                                       value: option.fetch(:value),
                                                       display_name: option.fetch(:displayName));
                       end
                     end
                   end
               end
             end
          end
        end
        trim_xml_from_element builder.target!
      end

      def go
        if @args.definitions.empty?
          raise Mio::Model::EmptyField, 'Field definitions to Mio::Model::MetadataDefinition must contain at least one definition'
        end

        unless look_up
          @object = create
        else
          @object = look_up
          set_start :stop
        end
        definition_path = "#{self.class.resource_name}/#{@object['id']}/definition"

        @client.definition definition_path, definition_xml

        set_enable
        return @object
      end

    end
  end
end

