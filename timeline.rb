#!/bin/env ruby
#
require 'yaml'
require 'colorize'
require 'pry'

CANON = YAML.load(File.read("./g-s-breakdown.yaml"))
PUBLICATION_ORDER = ["trial-by-jury", "sorcerer", "pinafore", "pirates", "patience", "iolanthe", "princess-ida", "mikado", "ruddigore", "yeoman", "gondoliers", "utopia-ltd", "grand-duke"]

shows = CANON.sort_by {|show| PUBLICATION_ORDER.find_index(show[:name])}

shows.each do |show|
  scenes = show[:scenes]
  show_name = show[:name]

  STDOUT.print "#{show_name}:\t".black.on_white

  scenes.each do |scene|
    type = scene[:type]
    length = scene[:length]

    c = case type
        when "song"
          " S ".black.on_blue
        when "finale"
          " F ".black.on_cyan
          #""
        when "recit"
          " R ".white.on_red
        when "dialog"
          " D ".white.on_red
        else
          ""
        end
    STDOUT.print c #* length
  end
  puts
  puts
end
