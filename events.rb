require 'sinatra'
require 'socket'

HOST = "mon03.core.cli.mbl.edu"
PORT = 2003

get '/:event' do
  @event = params[:event]
  haml :new, :locals => {:graphite_host => HOST}
end


get '/:event/new' do
  event = params[:event]
  graphite = TCPSocket.new(HOST, PORT)
  graphite.puts("events.test.#{event} 1 #{Time.now.to_i}")
  graphite.close
  redirect "/#{event}"
end
