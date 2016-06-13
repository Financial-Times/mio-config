class Mio
  class Model
    class ExtractResource < Model
      set_resource :resources

      field :name, String, 'Name of the Extract resource'
      field :visibility, Array,'IDs of accounts that may see this', [4]

      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.resources.impl.process.extract.MioExtractResource'

        {name: @args.name,
         pluginClass: plugin,
         visibilityIds: @args.visibility}
      end

    end
  end
end