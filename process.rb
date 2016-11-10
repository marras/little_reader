#!/usr/bin/env ruby

require 'net/http'
require 'open-uri'
require 'json'

output = {}

api_key = IO.read('api_key')
puts "API key: #{api_key}"

fout = File.open('mapping', 'wt')

File.open('lista.txt', 'rt') do |f|
  while word = f.readline.rstrip
    print "Processing word: '#{word}': "
    url = "https://www.googleapis.com/customsearch/v1?q=#{word}&imgSize=large&imgType=clipart&num=1&safe=high&searchType=image&#{api_key}"
    res = open(url).read
    link = JSON.load(res)['items'].first['link']
    puts link
    output[word] = link
    fout.puts "#{word}:#{link}"
    sleep 2
  end
end