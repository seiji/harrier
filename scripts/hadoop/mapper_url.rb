#!/usr/bin/env ruby
require 'mongo-hadoop'

MongoHadoop.map do |document|
  if document
    and document['entities']
    and document['entities']['urls']
    and document['entities']['urls'].size != 0

    entity_url = document['entities']['urls'][0]
    unless entity_url
      [{ :_id => 'NoEntity', :count => 1 }]
    else
      url= entity_url['expanded_url'] || entity_url['url'] || entity_url['display_url']
      unless url
        [{ :_id => 'NoURL', :count => 1 }]
      else
        [{ :_id => url,     :count => 1 }]
      end
    end
  else
    [{ :_id => 'NoURL', :count => 1 }]
  end
end

