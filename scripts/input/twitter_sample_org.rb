#!/usr/bin/env ruby
require 'pp'
require 'tweetstream'
require 'mongo'

require File.expand_path(File.dirname(__FILE__) + '/config')

@conn = Mongo::Connection.new
@db = @conn.db("twitter")
@tweets = @db.collection("sample")

TweetStream.configure do |config|
  config.username    = TWITTER_CONFIG["user"]
  config.password    = TWITTER_CONFIG["pass"]
  config.auth_method = :basic
  config.parser      = :yajl
end

EM.run do
  client = TweetStream::Client.new

  def save_tweet(status)
    EM.defer do
      if status.in_reply_to_user_id == nil
        if status.urls and status.urls.count > 0
          url = status.urls[0]
          url_text = url.expanded_url || url.display_url || url.url
          puts "[#{status.user.screen_name}] #{status.text}"
          puts url_text
        end
#        puts status.entities
        
#        pp status
        #        untie_link status.us
#        @tweets.insert(status.to_hash)
      end
    end
  end
  
  client.sample do |status|
    save_tweet(status)
  end
end
