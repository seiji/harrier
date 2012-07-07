#!/usr/bin/env ruby
require 'mongo-hadoop'

MongoHadoop.map do |document|
  if document['user']['lang'] == 'ja' and document['entities']['urls'] and document['entities']['urls'].size != 0
    expanded_url= document['entities']['urls'][0]['expanded_url']
    unless expanded_url
      [{ :_id => 'Unknown', :count => 0 }]
    else
      id = nil
      if expanded_url =~ /itunes\.apple\.com\/jp\/app\/([^\/]+)\/id(\d+)/
        app_name, id = $1, $2
      elsif expanded_url =~ /itunes\.apple\.com\/jp\/app\/id(\d+)/
        id = $1
      else
        warn expanded_url          
      end
      unless id
        [{ :_id => 'Unknown', :count => 0 }]
      else
        url = "http://itunes.apple.com/jp/app/id#{id}"
        [{ :_id => url, :count => 1 }]        
      end
    end
  else
    [{ :_id => 'Unknown', :count => 0 }]
  end
end

