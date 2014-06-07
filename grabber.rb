#!/bin/env ruby
#
require 'yaml'

show = ARGV.first
fail "provide show name" unless show

list = []

loop do
  line = STDIN.gets.chomp

  pair = line.split

  if pair.empty?
    next
  elsif pair.first == "fixup"
    list.pop
  elsif pair.length != 2
    puts "   ERROR: must be 2 tokens"
    next
  else
    list << pair
  end

  File.open("#{show}.yaml",'w') do |f|
    h = {}
    h[show] = list
    f.puts h.to_yaml
  end
end
