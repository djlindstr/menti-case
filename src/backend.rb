#!/usr/bin/env ruby

require 'webrick'
require 'httparty'
require 'json'
require_relative 'common.rb'

ENDPOINTS = {
  questions: "https://api.mentimeter.com/questions/#{UUID}",
  results: "https://api.mentimeter.com/questions/#{UUID}/result",
}

class Backend < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    question = HTTParty.get(ENDPOINTS[:questions]).find {|k, v| k == 'question'}
    results = HTTParty.get(ENDPOINTS[:results]).find {|k, v| k == 'results'}
    answer = [question, results].to_h
    response.header['Access-Control-Allow-Origin'] = "http://localhost:#{FRONTEND_PORT}"
    response.header['Access-Control-Allow-Methods'] = 'GET'
    response.header['Vary'] = 'Access-Control-Request-Headers'
    response.header['Access-Control-Allow-Headers'] = 'Content-Type, Accept'
    response.header['Access-Control-Request-Method'] = '*'
    response.content_type = 'application/json'
    response.body = JSON.generate(answer)
  end
end
