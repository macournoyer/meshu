require 'socket'
require 'thread'

server = TCPServer.new('localhost', 3000)

loop do
  client = server.accept

  Thread.new do
    puts client.read

    client.close
  end
end