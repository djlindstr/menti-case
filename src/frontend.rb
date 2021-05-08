#!/usr/bin/env ruby

require 'webrick'
require 'erb'
require_relative 'common.rb'

class Frontend < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    body = 'hello'
    template = ERB.new(File.read("#{__dir__}/barchart.rhtml"))
    response.body = template.result(binding)
  end
end
