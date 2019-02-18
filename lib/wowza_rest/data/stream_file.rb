require_relative 'base'

module WowzaRest
  module Data
    class StreamFile < Base
      attr_reader :stream_files

      def initialize(attrs = {})
        keys_reader :stream_files
        @stream_files = wrap_array_objects(
            attrs.delete('streamFiles'), StreamFileWrapper
        )
        super(attrs)
      end

      class StreamFileWrapper < Base; end
    end
  end
end
