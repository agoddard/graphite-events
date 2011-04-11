require 'sinatra'
require 'socket'

$graphite_host = "graphite.host"
port = 2003

get '/:event' do
  @event = params[:event]
  haml :new
end


get '/:event/new' do
  event = params[:event]
  graphite = TCPSocket.new($graphite_host,port)
  graphite.puts("events.test.#{event} 1 #{Time.now.to_i}")
  graphite.close
  redirect "/#{event}"
end
