#!/bin/env ruby

require 'pry'
require 'yaml'
require 'json'

# stacked bar
# categories: ["show_name1", "show_name2"]
# series: [{name: 'type 1', data: [s1t1, s2t2]},
#          {name: 'type 2', data: [s1t2, s2t2]}]

# scene_record
#   start_page: num
#   length: num
#   type: [song, dialog, etc...]
#
# show_record
#   name: name
#   scenes: [scene_record1, scene_record2]

canon = YAML.load(File.read("./g-s-breakdown.yaml"))

binding.pry

# vim: ft=ruby
