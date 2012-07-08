require 'pit'

TWITTER_CONFIG = Pit.get('twitter.com')
MONGO_HOME="/usr/local/mongodb"

unless TWITTER_CONFIG
  raise "u set TWITTER_CONFIG"
end
