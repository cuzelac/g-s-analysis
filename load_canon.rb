#!/bin/env ruby

require 'pry'
require 'yaml'
require 'json'

def load_shows(file)
  YAML.load(File.read(file))
end

# stacked bar
# categories: ["show_name1", "show_name2"]
# series: [{name: 'type 1', data: [s1t1, s2t2]},
#          {name: 'type 2', data: [s1t2, s2t2]}]

# scene_record
#   start_page: num
#   length: num
#   type: [song, dialog, etc...]
#

def build_scene_record(scene, next_scene)
  r = {}
  r[:type] = scene[0]
  r[:start_page] = scene[1].to_i
  r[:length] = next_scene[1].to_i - scene[1].to_i
  r[:length] = 1 if r[:length].zero?
  r
end

# show_record
#   name: mikado
#   scenes: [scene_record1, scene_record2]

def build_show_record(show_name, scene_ary)
  scenes = []
  scene_ary.each_with_index do |scene,i|
    # fake a scene if we're at the end of the sho
    if scene.first == "end"
      scenes << build_scene_record(scene,scene)
    else
      scenes << build_scene_record(scene,scene_ary[i+1])
    end
  end
  {:name => show_name,
   :scenes => scenes
  }
end

y = load_shows("./g-s-breakdown.yaml")
canon = []

y.keys.each do |show_name|
  canon << build_show_record(show_name, y[show_name])
end

binding.pry

# vim: ft=ruby
