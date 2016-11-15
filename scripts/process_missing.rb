#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

output = {}

api_key = IO.read('api_key')
puts "API key: #{api_key}"
google = Google.new(api_key)

current_words = File.readlines('mapping').map(&:strip).map do |line|
  line.split(':').first
end

fout = File.open('mapping', 'at')

File.readlines('lista.txt').map(&:word).each do |word|
  print "Processing word: '#{word}': "
  if current_words.include? word
    puts "Already mapped!"
    next
  end

  link = google.search(word, 2)
  puts link
  output[word] = link

  match_extension = link.match(/https?:\/\/.*\.(bmp|jpg|png|jpeg|gif)\??.*/i)
  if match_extension
    extension = match_extension[1]

    filename = "#{word.to_ascii}.#{extension}"
    fout.puts "#{word}:assets/#{filename}"

    # Download
    word = word.to_ascii
    google.save_file(link, "tmp/#{filename}")
  else
    puts "Incompatible image format!"
  end

  sleep 2
end
