#! /usr/bin/ruby

require 'sinatra/base'
require 'thin'
require 'redis'
require 'json'

$redis = Redis.new(:host => "127.0.0.1", :port => 6379)

class App < Sinatra::Base

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  get '/messages.json' do
    count = $redis.get("messages:counter").to_i || 0

    0.upto(count).map do |id|
      msg = $redis.get("message-#{id}")
      next if msg.nil? # TODO: why are these appearing?
      { id => msg }
    end.to_json
  end

end

Thin::Server.start App, '0.0.0.0', 4000
