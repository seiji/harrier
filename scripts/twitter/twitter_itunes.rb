#!/usr/bin/env ruby
require File.expand_path(File.dirname(__FILE__) + '/config')

TRACK="itunes"
DB_NAME="itunes"

if $0 == __FILE__  
  `curl https://stream.twitter.com/1/statuses/filter.json?track=#{TRACK} -u#{TWITTER_CONFIG['user']}:#{TWITTER_CONFIG['pass']} | mongoimport -d twitter -c #{DB_NAME}`
end
