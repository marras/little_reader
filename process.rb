#!/usr/bin/env ruby

require 'open-uri'
require 'json'
require 'webrick/httputils'

output = {}

api_key = IO.read('api_key')
puts "API key: #{api_key}"

fout = File.open('mapping', 'wt')

File.open('lista.txt', 'rt') do |f|
  while word = f.readline.rstrip
    print "Processing word: '#{word}': "
    word.force_encoding('binary')
    esc_word = WEBrick::HTTPUtils.escape(word)
    url = "https://www.googleapis.com/customsearch/v1?q=#{esc_word}&imgSize=large&imgType=clipart&num=1&safe=high&searchType=image&hl=pl&lr=lang_pl&#{api_key}"
    res = open(url).read
    link = JSON.load(res)['items'].first['link']
    puts link
    output[word] = link
    fout.puts "#{word}:#{link}"

    extension = link.match(/https?:\/\/.*\.(bmp|jpg|png|jpeg|gif)\??.*/i)[1]

    # Download
    File.open("apps/web/assets/images/#{word}.#{extension}", "wb") do |saved_file|
      open(link, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end

    sleep 2

  end
end