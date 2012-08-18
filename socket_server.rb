#! /usr/bin/ruby

require 'eventmachine'
require 'em-websocket'
require 'em-http-request'
require 'json'

@sockets = []

EventMachine.run do

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |socket|
    socket.onopen do
      # Register the socket and broadcast a message to all clients
      @sockets << socket
      json = { :type => :Connect, :count => @sockets.count }.to_json
      @sockets.each{ |sock| sock.send(json) }
    end

    socket.onmessage do |msg|
      # Persist the message
      # TODO
      poll_id = msg[0..5].gsub('x', '')
      text = msg[6..-1]

      http = EventMachine::HttpRequest.new("http://localhost:3000/polls/#{poll_id}/comments/").post :body => { text: text }

      puts "server id: #{poll_id}"
      puts "server text: #{text}"

      # Broadcast to connected sockets
      @sockets.each do |sock|
        sock.send( { :type => :Message, :data => text }.to_json )
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
