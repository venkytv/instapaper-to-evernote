#!/usr/bin/env ruby

require 'instapaper'
require 'uri'
require 'yaml'

username = ENV.fetch("INSTAPAPER_USERNAME")
password = ENV.fetch("INSTAPAPER_PASSWORD")
p username

credentials = {
  consumer_key: ENV.fetch("API_CONSUMER_KEY"),
  consumer_secret: ENV.fetch("API_CONSUMER_SECRET"),
}

client = Instapaper::Client.new(credentials)
token = client.access_token(username, password)
client.oauth_token = token.oauth_token
client.oauth_token_secret = token.oauth_token_secret
client.verify_credentials

client.bookmarks.each do |bookmark|
  id = bookmark.bookmark_id
  title = bookmark.title.chomp
  if not title.empty?
    puts title
    text = ''
    begin
      text = client.get_text(id)
    rescue Instapaper::Error
      $stderr.puts "ERROR: No text for article: #{title}"
      next
    end
    client.star_bookmark(id)
    client.archive_bookmark(id)
  else
    url = bookmark.url
    $stderr.puts "Skipping URL: #{url}"
  end
end
