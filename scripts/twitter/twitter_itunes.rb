#!/usr/bin/env ruby
require 'pit'
TWITTER_CONFIG = Pit.get('twitter.com')
TRACK="itunes"

if $0 == __FILE__
  `curl https://stream.twitter.com/1/statuses/filter.json?track="#{TRACK}" -u#{TWITTER_CONFIG['user']}:#{TWITTER_CONFIG['pass']} | mongoimport -d twitter -c in`
end
