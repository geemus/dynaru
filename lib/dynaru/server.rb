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


    get '/api/:key' do |key|
      Thread.main[key]
    end

    put '/api/:key' do |key|
      Thread.main[key] = request.body.read
      status(204)
    end


    get '/data/:key' do |key|
    end

    put '/data/:key' do |key|
    end


    get '/members' do
    end

    put '/members' do
    end

    post '/members' do
    end

  end
end

Dynaru::Server.run
