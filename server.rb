#!/usr/bin/env ruby

require 'webrick'

PORT = ENV['LISTEN_PORT']

class Backend < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.status = 200
    response.body = "Hello world"
  end
end

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount "/service", Backend

trap("INT") {
  server.shutdown
}

server.start
