#!/bin/env ruby
#
require 'yaml'
require 'colorize'
require 'pry'

CANON = YAML.load(File.read("./g-s-breakdown.yaml"))
PUBLICATION_ORDER = ["trial-by-jury", "sorcerer", "pinafore", "pirates", "patience", "iolanthe", "princess-ida", "mikado", "ruddigore", "yeoman", "gondoliers", "utopia-ltd", "grand-duke"]

def timeline(print_acts=[1,2,3],print_shows=[])
  shows = CANON.sort_by {|show| PUBLICATION_ORDER.find_index(show[:name])}

  shows.each do |show|
    scenes = show[:scenes]
    show_name = show[:name]

    if 0 != print_shows.length
      next unless print_shows.include?(show_name)
    end

    STDOUT.print " #{show_name}:".black.on_white
    STDOUT.print "\t"
#    STDOUT.print "\t" if ["mikado", "yeoman"].include?(show_name)

    act = 1

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
      if print_acts.include?(act)
        STDOUT.print c #* length
      end
      act += 1 if type == "finale"
    end
    puts
    puts
  end
end

#puts "Full Shows"
#timeline(1..3,ARGV)
puts "Act 1"
timeline([1],ARGV)
puts "Act 2 (+ 3)"
timeline([2,3],ARGV)
