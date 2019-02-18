require 'wowza_rest/applications'
require 'wowza_rest/instances'
require 'wowza_rest/publishers'
require 'wowza_rest/smils'
require 'wowza_rest/stream_files'

module WowzaRest
  module API
    # include all api modules here
    include WowzaRest::Applications
    include WowzaRest::Instances
    include WowzaRest::Publishers
    include WowzaRest::SMILs
    include WowzaRest::StreamFiles
  end
end
