#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

output = {}

api_key = IO.read('api_key')
puts "API key: #{api_key}"
google = Google.new(api_key)

fout = File.open('mapping', 'wt')

File.readlines('lista.txt').map(&:word).each do |word|
  print "Processing word: '#{word}': "
  link = google.search(word)
  puts link
  output[word] = link

  extension = link.match(/https?:\/\/.*\.(bmp|jpg|png|jpeg|gif)\??.*/i)[1]

  filename = "#{word.to_ascii}.#{extension}"
  fout.puts "#{word}:assets/#{filename}"

  # Download
  word = word.to_ascii
  google.save_file(link, "tmp/#{filename}")

  sleep 2
end