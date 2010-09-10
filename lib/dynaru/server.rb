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

    def initialize
      Thread.main[:data] = {}
      @data = Thread.main[:data]
      Thread.main[:members] = {}
      @members = Thread.main[:members]
      super
    end

    get '/api/:key' do |key|
      @data[key]
    end

    put '/api/:key' do |key|
      @data[key] = request.body.read
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
