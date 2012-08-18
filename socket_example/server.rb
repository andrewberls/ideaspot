#! /usr/bin/ruby
# EM server command
# ./server.rb
#
# redis server command
# redis-server redis-conf &

require 'eventmachine'
require 'em-websocket'
require 'em-hiredis'
require 'json'

@sockets = []

EventMachine.run do
  redis = EM::Hiredis.connect
  redis.set("messages:counter", 1)

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |socket|
    socket.onopen do
      # Register the socket and broadcast a message to all clients
      @sockets << socket
      json = { :type => :Connect, :count => @sockets.count }.to_json
      @sockets.each{ |sock| sock.send(json) }
    end

    socket.onmessage do |msg|
      # Persist to redis
      # TODO: because of the deferred nature, this fails once on initialization
      # e.g., the message saves to message-<nil> instead of properly waiting
      # for the count

      redis.get("messages:counter") { |count| redis.set("message-#{count}", msg) }
      redis.incr("messages:counter")

      # Broadcast to connected sockets
      @sockets.each do |sock|
        sock.send( { :type => :Message, :data => msg }.to_json )
      end
    end

    socket.onclose do
      # Delete the socket and broadcast a message to all clients
      @sockets.delete(socket)
      json = { :type => :Connect, :count => @sockets.count }.to_json
      @sockets.each { |sock| sock.send(json) }
    end
  end

  puts ">> WebSocket server listening on 0.0.0.0:8080"

end
