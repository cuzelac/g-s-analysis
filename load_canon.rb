#!/bin/env ruby

require 'pry'
require 'yaml'
require 'json'

# stacked bar
# categories: ["show_name1", "show_name2"]
# series: [{name: 'type 1', data: [s1t1, s2t1]},
#          {name: 'type 2', data: [s1t2, s2t2]}]

def build_stacked_bar(canon, restrict_types=true)
  shows = canon.collect {|show| show[:name]} #.sort_by {|n| PUBLICATION_ORDER.find_index(n)}

  # we'll store
  # h[type] = [num_types_in_show1, num_types_in_show2 ...]
  collection = {}

  keep_types = [:song, :dialog, :recit, :finale]

  # initialize the collection hash
  canon.each do |show|
    show[:scenes].each {|scene| collection[scene[:type]] = []}
  end

  # keep only the types we want to keep
  if restrict_types
    collection.delete_if do |type, v|
      !keep_types.include?(type.to_sym)
    end
  end

  canon.each do |show|
    scenes = show[:scenes]
    # count the occurances of each type
    collection.keys.each do |type|
      count = 0
      scenes.each do |scene|
        count += 1 if scene[:type] == type
      end
      collection[type] << count
    end
  end

  series = []
  collection.each do |type,arr|
    series << {"name" => type,
     "data" => arr
    }
  end

  puts "categories: #{JSON.generate(shows)}"
  puts "series: #{JSON.generate(series)}"
  return shows, series
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
PUBLICATION_ORDER = ["trial-by-jury", "sorcerer", "pinafore", "pirates", "patience", "iolanthe", "princess-ida", "mikado", "ruddigore", "yeoman", "gondoliers", "utopia-ltd", "grand-duke"]

categories, series = build_stacked_bar(CANON)
binding.pry

# vim: ft=ruby
