task :default => :build

task :build do
  puts "build"
end

task :get do
  require 'pit'
  TWITTER_CONFIG = Pit.get('twitter.com')
  puts "get twitter data"
  `curl https://stream.twitter.com/1/statuses/filter.json?track="itunes" -u#{TWITTER_CONFIG['user']}:#{TWITTER_CONFIG['pass']} | mongoimport -d twitter -c in`
end

task :count do
  puts "counting"
  `hadoop jar scripts/mongo-hadoop-streaming-assembly*.jar -mapper scripts/mapper_itunes_url.rb -reducer scripts/reducer.rb -inputURI mongodb://127.0.0.1/twitter.in -outputURI mongodb://127.0.0.1/twitter.out`
end
