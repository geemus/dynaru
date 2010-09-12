require 'rubygems'
require 'sinatra/base'
require 'dynaru/storage'

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
      @data = Dynaru::Storage.new(:data)
      @members = Dynaru::Storage.new(:members)
      super
    end

    # redirect to coordinator or get value
    get '/api/:key' do |key|
      @data[key]
    end

    # redirect to coordinator or set value
    put '/api/:key' do |key|
      @data[key] = request.body.read
      status(204)
    end


    # get local value
    get '/data/:key' do |key|
    end

    # set local value
    put '/data/:key' do |key|
    end


    # update data
    put '/data' do
    end

    # sync data
    post '/data' do
    end


    # get all members
    get '/members' do
    end

    # update members
    put '/members' do
    end

    # sync members
    post '/members' do
    end

  end
end
