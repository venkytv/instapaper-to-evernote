#!/usr/bin/env ruby

require 'instapaper'
require 'uri'
require 'yaml'

credentials = {}
username = password = ''

dirname = File.dirname(__FILE__)

envfile = File.join(dirname, 'env.yaml')
abort "ENV file missing: #{envfile}" unless File.exist? envfile
config = YAML.load(File.open(envfile))
credentials = {
  consumer_key: config['consumer_key'],
  consumer_secret: config['consumer_secret'],
}
username = config['username']
password = config['password']

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
