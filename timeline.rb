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

  STDOUT.print "#{show_name}:".black.on_white
  STDOUT.print "\t"
  STDOUT.print "\t" if ["mikado", "yeoman"].include?(show_name)

  scenes.each do |scene|
    type = scene[:type]
    length = scene[:length]

    c = case type
        when "song"
          " S ".black.on_yellow
        when "finale"
          " F ".white.on_black
          #""
        when "recit"
          " R ".black.on_green
        when "dialog"
          " D ".white.on_blue
        else
          ""
        end
    STDOUT.print c #* length
  end
  puts
  puts
end
