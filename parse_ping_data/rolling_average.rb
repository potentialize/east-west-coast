#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'each_file.rb'

CACHE_SIZE = 500

# modifies prevs array
def cache(prevs, value)
  prevs.pop if prevs.size >= CACHE_SIZE

  prevs.unshift(value)
end

# return average from prevs cache
def avg(prevs)
  avg = prevs.reduce(:+) / prevs.size
  avg.round(3)
end

each_file("avg#{CACHE_SIZE}") do |path_in, path_out|
  # NOTE: may override files at output location!
  file_in = File.open(path_in, 'r')
  file_out = File.open(path_out, 'w')

  # 0: most recent value
  prevs = []

  file_in.each_line do |line|
    # NOTE: does not catch ping or connect
    if line[0] == '#'
      # echo comments
      file_out << line

      # skip comments
      next
    end

    # split
    cols = line.split(' ')
    _time = cols[0].to_i
    ping = cols[1].to_f # NOTE: converts "loss" into 0.0

    # cache ping in prevs
    cache(prevs, ping)

    file_out << "#{cols[0]} #{avg(prevs)}\n"
  end

  # clean up
  file_in.close
  file_out.close
end
