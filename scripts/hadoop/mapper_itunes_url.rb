#!/usr/bin/env ruby
require 'mongo-hadoop'
require 'url_expander'
require 'hugeurl'

MongoHadoop.map do |document|
  if document['entities']['urls'] and document['entities']['urls'].size != 0
    expanded_url= document['entities']['urls'][0]['expanded_url']
    unless expanded_url
      [{ :_id => 'NoExpand', :count => 1 }]
    else
      country, id = nil, nil
      if expanded_url =~ /itunes\.apple\.com\/([^\/]+)\/app\/([^\/]+)\/id(\d+)/
        country, app_name, id = $1, $2, $3
      elsif expanded_url =~ /itunes\.apple\.com\/([^\/]+)\/app\/id(\d+)/
        country, id = $1, $2
      elsif expanded_url =~ /itunes\.apple\.com\/app\/([^\/]+)\/id(\d+)/
        app_name, id = $1, $2
      else
        warn "WARN #{expanded_url}"
        begin
          warn puts URI.parse(expanded_url).to_huge
   #       url = UrlExpander::Client.expand(expanded_url)
   #       puts url
        rescue 
        end
      end
      unless id 
        [{ :_id => 'UnknownID', :count => 1 }]
      else
        url = "http://itunes.apple.com/app/id#{id}"
        [{ :_id => url, :count => 1 }]        
      end
    end
  else
    [{ :_id => 'NoLink', :count => 1 }]
  end
end

