require 'pit'

TWITTER_CONFIG = Pit.get('twitter.com')

unless TWITTER_CONFIG
  raise "u set TWITTER_CONFIG"
end

