require 'dynaru/storage'
require 'json'

module Dynaru
  class Members < Dynaru::Storage

    def initialize
      super(:members)
    end

    def compare_keys(remote_keys)
      local_keys = self.keys
      data = {}
      for key in local_keys
        unless remote_keys.include?(key)
          data[key] = self.get(key)
        end
      end

      keys = []
      for key in remote_keys
        unless local_keys.include?(key)
          keys << key
        end
      end
      { :data => data, :keys => keys }
    end

    def gossip
      peer = keys[rand(keys.length)]
      connection = Excon.new(peer)

      response = connection.request(:method => 'POST', :body => keys)
      response = JSON.parse(response.body)

      for key, value in response['data']
        self[key] = value
      end

      data = []
      for key in response['keys']
        data[key] = self[key]
      end

      connection.request(:method => 'PUT', :body => { 'data' => data }.to_json)
    end

    def update(data)
      for key, value in data
        self[key] = value
      end
    end

  end
end
