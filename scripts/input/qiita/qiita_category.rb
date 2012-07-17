#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'active_support/core_ext'

if $0 == __FILE__
  # write this
  xml = `curl http://qiita.com/tags/Ruby/feed.atom`
  json = Hash.from_xml(xml).to_json
  puts json
end
