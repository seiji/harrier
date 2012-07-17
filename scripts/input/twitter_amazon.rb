#!/usr/bin/env ruby
require File.dirname(__FILE__) + './config'

TRACK="amazon"
DB_NAME="amazon"

if $0 == __FILE__
  `curl https://stream.twitter.com/1/statuses/filter.json?track=#{TRACK} -u#{TWITTER_CONFIG['user']}:#{TWITTER_CONFIG['pass']} | #{MONGO_HOME}/bin/mongoimport -d twitter -c #{DB_NAME}`
end
