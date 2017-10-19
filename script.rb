require 'feedjira'
require 'faraday'
require 'qiita'

require './entry'

client = Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])

rss_url = ARGV[0]

res = Faraday.get rss_url

Feedjira::Feed.add_feed_class(Feedjira::Parser::Atom)
feed = Feedjira::Feed.parse res.body

feed.entries.select do |entry|
  item_id = entry.url.split('items/')[1]
  item_hash = client.get_item(item_id).body.to_h
  hatebu_num = Faraday.get("http://api.b.st-hatena.com/entry.count?url=#{entry.url.gsub!(/http/, 'https')}").body

  my_entry = Entry.new(
    id: item_id,
    title: entry.title,
    author: entry.author,
    like_num: item_hash['likes_count'],
    hatebu_num: hatebu_num
  )
  puts my_entry.to_csv
  sleep(10)
end
