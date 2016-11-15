#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

api_key = IO.read('api_key')
puts "API key: #{api_key}"
google = Google.new(api_key)

fout = File.open('mapping', 'wt')

File.readlines('lista.txt').map(&:strip).each do |word|
  print "Processing word: '#{word}': "
  link = google.search(word)
  puts link

  filename = google.process_link(word, link)
  fout.puts "#{word}:assets/#{filename}"

  sleep 2
end