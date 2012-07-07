#!/usr/bin/env ruby
require 'pit'
TWITTER_CONFIG = Pit.get('twitter.com')
TRACK="itunes"
DB_NAME="itunes"

if $0 == __FILE__
  unless TWITTER_CONFIG
    raise "u set TWITTER_CONFIG"
  end
  
  `curl https://stream.twitter.com/1/statuses/filter.json?track=#{TRACK} -u#{TWITTER_CONFIG['user']}:#{TWITTER_CONFIG['pass']} | mongoimport -d twitter -c #{DB_NAME}`
end
