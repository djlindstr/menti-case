#!/usr/bin/env ruby

require 'webrick'
require_relative 'common.rb'
require_relative 'backend.rb'
require_relative 'frontend.rb'

backend = WEBrick::HTTPServer.new(Port: BACKEND_PORT)
frontend = WEBrick::HTTPServer.new(Port: FRONTEND_PORT)

backend.mount "/#{UUID}", Backend
frontend.mount "/#{UUID}", Frontend

servers = [frontend, backend]

trap("INT") {
  servers.each(&:shutdown)
}

threads = []
servers.each do |server|
  threads << Thread.new { server.start }
end

threads.each(&:join)
