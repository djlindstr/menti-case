#!/usr/bin/env ruby

require 'webrick'

PORT = 8123

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.status = 200
    response.body = "Hello world"
  end
end

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount "/", MyServlet

trap("INT") {
  server.shutdown
}

server.start
