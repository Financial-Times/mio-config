class Mio
  class Model
    class Extract < Model
      set_resource :actions

      field :name, String, 'Name of the Add To Group action'
      field :visibility, Array,'IDs of accounts that may see this', [4]
      field :autoApproveFrames, Symbol, 'Auto approve extracted frames', :true
      field :masterFrame, Fixnum, 'Seconds for master frame', 10
      field :setFramesOfParentAsset, Symbol, 'Set key frame on parent asset', :false
      field :numberOfKeyFramesToExtract, Fixnum, 'Number of key frames to extract', 10
      field :enable, Symbol, ':true or :false', :true
      field :start, Symbol, ':true or :false', :true

      def create_hash
        plugin = 'tv.nativ.mio.enterprise.execution.action.file.impl.extract.DefaultExtractCommand'

        {name: @args.name,
         pluginClass: plugin,
         type: 'extract',
         visibilityIds: @args.visibility}
      end

      def config_hash
        {"extract-metadata": false,
          "extract-frames": { "approve-frames": @args.autoApproveFrames,
                              "set-master-frame": @args.masterFrame,
                              "set-frames-on-parent-asset": @args.setFramesOfParentAsset,
                              "fixed-number": @args.numberOfKeyFramesToExtract}
        }
      end

    end
  end
end