#!/usr/bin/env ruby

require 'webrick'
require 'httparty'
require 'json'

PORT = ENV['LISTEN_PORT']
UUID = '48d75c359ce4'
ENDPOINTS = {
  questions: "https://api.mentimeter.com/questions/#{UUID}",
  results: "https://api.mentimeter.com/questions/#{UUID}/result",
}

class Backend < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    question = HTTParty.get(ENDPOINTS[:questions]).find {|k, v| k == 'question'}
    results = HTTParty.get(ENDPOINTS[:results]).find {|k, v| k == 'results'}
    answer = [question, results].to_h
    response.content_type = 'application/json'
    response.body = JSON.generate(answer)
  end
end

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount "/service", Backend

trap("INT") {
  server.shutdown
}

server.start
