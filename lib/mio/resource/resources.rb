class Mio
  class Resources < Mio::Client

    @@resource  = '/api/resources'

    def self.create(name, type, visibility)
      plugin_class = {
        vfs: 'tv.nativ.mio.enterprise.resources.impl.capacity.storage.vfs.VFSStorageResource',
        gay: 'shit-stabber'
      }[type]
      payload = {
        name: name,
        pluginClass: plugin_class,
        visibilityIds: [visibility]
      }.to_json

      create_or_update(payload)
    end

  end
end
