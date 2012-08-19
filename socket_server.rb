#! /usr/bin/ruby

require 'eventmachine'
require 'em-websocket'
require 'em-http-request'
require 'json'

@sockets = []

# TODO: Handle ideas in real time

EventMachine.run do

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |socket|
    socket.onopen do
      # Register the socket and broadcast connection status update to all clients
      @sockets << socket
      json = { :type => :Connect, :count => @sockets.count }.to_json
      @sockets.each{ |sock| sock.send(json) }
    end

    socket.onmessage do |msg|
      # Persist the message
      # The poll id is padded with junk to 6 digits,
      # and passed in concatenated with the actual message
      # e.g. '124xxxHello World!'
      poll_id = msg[0..5].gsub('x', '')
      text    = msg[6..-1]

      # We have the attributes we need - post them over to the API
      # and let the controller deal with the data
      http = EventMachine::HttpRequest.new("http://localhost:3000/polls/#{poll_id}/comments/")
      http.post :body => { text: text }

      # Broadcast the message to connected sockets
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
