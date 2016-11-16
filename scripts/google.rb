require 'open-uri'
require 'json'
require 'webrick/httputils'

class Google
  attr_reader :api_key

  def initialize(api_key)
    @api_key = api_key
  end

  def search(word, num = 1)
    word.force_encoding('binary')
    esc_word = WEBrick::HTTPUtils.escape(word)
    url = "https://www.googleapis.com/customsearch/v1?q=#{esc_word}&imgSize=large&imgType=clipart&num=#{num}&safe=high&searchType=image&hl=pl&lr=lang_pl&#{api_key}"
    res = open(url).read
    JSON.load(res)['items'][num-1]['link']
  end

  def save_file(url, path)
    File.open(path, "wb") do |saved_file|
      open(url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end

  def process_link(word, link)
    match_extension = link.match(/https?:\/\/.*\.(bmp|jpg|png|jpeg|gif)\??.*/i)
    if match_extension
      extension = match_extension[1]

      filename = "#{word.to_ascii}.#{extension}"
      save_file(link, "tmp/new_images/#{filename}")
    else
      puts "Incompatible image format!" and return
    end
    filename
  end
end
