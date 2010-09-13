require 'rubygems'
require 'sinatra/base'
require 'dynaru/members'
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
      @members = Dynaru::Members.new
      super
    end

    # redirect to coordinator or get value
    get '/api/:key' do |key|
      @data.get(key)
    end

    # redirect to coordinator or set value
    put '/api/:key' do |key|
      @data.set(key, request.body.read)
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
      content_type('application/json')
      response = @members.all
      response.to_json
    end

    # takes a list of key/value pairs and updates local members
    put '/members' do
      content_type('application/json')
      data = JSON.parse(request.body.read)
      @members.update(data)
      status(204)
    end

    # takes a list of keys from a peer
    # returns { 'data' => requested key/value pairs, 'keys' => keys requiring updates)
    post '/members' do
      content_type('application/json')
      data = JSON.parse(request.body.read)
      response = @members.compare_keys(data)
      response.to_json
    end

  end
end
