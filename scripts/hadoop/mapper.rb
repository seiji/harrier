#!/usr/bin/env ruby
require 'mongo-hadoop'

MongoHadoop.map do |document|
  if document['source'] 
    [{ :_id => document['source'], :count => 1 }]
  else
    [{ :_id => 'Unknown', :count => 1 }]
  end
end

