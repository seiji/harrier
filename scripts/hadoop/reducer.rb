#!/usr/bin/env ruby
require 'mongo-hadoop'

MongoHadoop.reduce do |key, values|
  count = 0
  values.each do |value|
    warn value
    count += value["count"]
  end
  {:_id => key, :count => count}
end
