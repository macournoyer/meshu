require 'socket'
require 'rubygems'
require 'memcached'
require "benchmark"

def req(method, path, data='')
  socket = TCPSocket.new("0.0.0.0", 3000)
  socket.write("#{method} /#{path} HTTP/1.1\r\nContent-Length: #{data.size}\r\n\r\n#{data}")
  resp = socket.read
  socket.close
  resp
end

$cache = Memcached.new("127.0.0.1:11211")

data = "X" * (1024 * 50)

req("POST", 1, data)
$cache.set 'test', data

TESTS = 5000
Benchmark.bmbm do |results|
  results.report("thin:") { TESTS.times { req("GET", 1) } }
  results.report("memc:") { TESTS.times { $cache.get 'test' } }
end
