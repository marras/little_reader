#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

api_key = IO.read('api_key')
puts "API key: #{api_key}"
google = Google.new(api_key)

mapping_lines = File.readlines('mapping').map(&:strip).map{ |line| line.split(':') }
current_words = Hash[mapping_lines]

File.readlines('lista.txt').map(&:strip).each do |word|
  print "Processing word: '#{word}': "
  if current_words.keys.include? word
    puts "Already mapped!"
    next
  end

  link = google.search(word, 2)
  puts link

  filename = google.process_link(word, link)
  current_words[word] = "assets/#{filename}" if filename

  sleep 2
end

File.open('mapping', 'wt') do |fout|
  current_words.each { |word, link| fout.puts "#{word}:#{link}" }
end
