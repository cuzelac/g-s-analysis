#!/bin/env ruby

require 'pry'
require 'yaml'
require 'json'

# stacked bar
# categories: ["show_name1", "show_name2"]
# series: [{name: 'type 1', data: [s1t1, s2t1]},
#          {name: 'type 2', data: [s1t2, s2t2]}]

def build_stacked_bar(canon)
  shows = canon.collect {|show| show[:name]}

  # we'll store
  # h[type] = [
  collection = {}

  # initialize the collection hash
  canon.each do |show|
    show[:scenes].each {|scene| collection[scene[:type]] = []}
  end

  canon.each do |show|
    scenes = show[:scenes]
    # count the occurances of each type
    collection.keys.each do |type|
      count = 0
      scenes.each do |scene|
        # IMPLEMENT ME
      end
      collection[type] << count
    end
  end
end

# scene_record
#   start_page: num
#   length: num
#   type: [song, dialog, etc...]
#
# show_record
#   name: name
#   scenes: [scene_record1, scene_record2]

CANON = YAML.load(File.read("./g-s-breakdown.yaml"))

binding.pry

# vim: ft=ruby
