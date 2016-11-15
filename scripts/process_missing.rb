#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

api_key = IO.read('api_key')
puts "API key: #{api_key}"
google = Google.new(api_key)

mapping_lines = File.readlines('mapping').map(&:strip).map{ |line| line.split(':') }
current_words = Hash[mapping_lines]

File.readlines('lista.txt').map(&:word).each do |word|
  print "Processing word: '#{word}': "
  if current_words.keys.include? word
    puts "Already mapped!"
    next
  end

  link = google.search(word, 2)
  puts link
  current_words[word] = link

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

File.open('mapping', 'wt') do |fout|
  current_words.each { |word, link| fout.puts "#{word}:#{link}" }
end
