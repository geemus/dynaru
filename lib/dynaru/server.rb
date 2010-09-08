require 'rubygems'
require 'sinatra/base'

module Dynaru
  class Server < Sinatra::Base

    def self.run
      Rack::Handler::WEBrick.run(
        Dynaru::Server.new,
        :Port => 9292,
        :AccessLog => [],
        :Logger => WEBrick::Log.new(nil, WEBrick::Log::ERROR)
      )
    end

    before { content_type('application/json') }

    delete '/data/:key' do |key|
      Thread.main[key] = nil
    end

    get '/data/:key' do |key|
      Thread.main[key]
    end

    put '/data/:key' do |key|
      Thread.main[key] = {
        :updated_at => time.now,
        :value      => request.body.read
      }
      status(204)
    end

  end
end

Dynaru::Server.run
