#!/usr/bin/env ruby
require 'unidecoder'
require_relative 'google'

mapping_lines = File.readlines('mapping').map(&:strip).map{ |line| line.split(':') }
current_words = Hash[mapping_lines]

PATH='tmp'

puts "This script will remove any entries not matched by images in #{PATH}/ directory from mapping!"
sleep 3

filtered_mapping = current_words.select do |word, path|
  file = path.gsub(/assets\//, '')
  puts file
  File.exists?("#{PATH}/#{file}") || File.exists?("apps/web/assets/images/#{file}")
end

File.open('mapping', 'wt') do |fout|
  filtered_mapping.each { |word, link| fout.puts "#{word}:#{link}" }
end

