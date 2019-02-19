require_relative 'data/stream_file'
require_relative 'data/stream_file_short'

module WowzaRest
  module StreamFiles
    def streamfiles
      response = connection.request(
          :get, '/streamfiles'
      )
      return unless response.code == 200
      response.parsed_response['streamFiles']
          .map { |e| WowzaRest::Data::StreamFile.new(e) }
    end

    def get_streamfile(streamfile_name)
      response = connection.request(:get, "/streamfiles/#{streamfile_name}")
      return unless response.code == 200
      WowzaRest::Data::StreamFile.new(response.parsed_response)
    end

    def create_streamfile(streamfile_name, streamfile_body)
      apply_streamfile_checks(streamfile_name, streamfile_body)
      connection.request(:post, "/streamfiles/#{streamfile_name}",
                         body: streamfile_body.to_json)
    end

    def update_streamfile(streamfile_name, streamfile_body)
      apply_streamfile_checks(streamfile_name, streamfile_body)
      connection.request(:put, "/streamfiles/#{streamfile_name}",
                         body: streamfile_body.to_json)
    end

    def delete_streamfile(streamfile_name)
      apply_streamfile_checks(streamfile_name)
      connection.request(:delete, "/streamfiles/#{streamfile_name}")
    end

    def connect_streamfile(streamfile_name, appname)
      connection.request(:put, "/streamfiles/#{streamfile_name}/actions/connect?connectAppName=#{appname}&appInstance=_definst_&mediaCasterType=rtp")
    end

    def disconnect_streamfile(streamfile_name, appname)
      connection.request(:put, "/applications/#{appname}/instances/_definst_/incomingstreams/#{streamfile_name}.stream/actions/disconnectStream")
    end

    def apply_streamfile_checks(streamfile_name, streamfile_body = {})
      if !streamfile_body.is_a?(Hash) && !streamfile_body.is_a?(WowzaRest::Data::StreamFile)
        raise WowzaRest::Errors::InvalidArgumentType,
              "Second argument expected to be Hash or WowzaRest::Data::StreamFile
              instance, got #{streamfile_body.class} instead"
      elsif !streamfile_name.is_a?(String)
        raise WowzaRest::Errors::InvalidArgumentType,
              "First argument expected to be String got #{streamfile_name.class}"
      end
    end
  end
end
