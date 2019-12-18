#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './each_file.rb'

# first element of group treated as label

NYC_AMS = ['NYC_AMS', 'nyc-to-ams.txt', 'ams-to-nyc.txt'].freeze
NYC_SF = ['NYC_SF', 'nyc-to-sanfran.txt', 'sanfran-to-nyc.txt'].freeze
SF_AMS = ['SF_AMS', 'sanfran-to-ams.txt', 'ams-to-sanfran.txt'].freeze

WEST_EAST = [
  'WEST_EAST',
  'sanfran-to-nyc.txt', 'nyc-to-ams.txt', 'sanfran-to-ams.txt'
].freeze

EAST_WEST = [
  'EAST_WEST',
  'nyc-to-sanfran.txt', 'ams-to-nyc.txt', 'ams-to-sanfran.txt'
].freeze

cats = ['avg100']
# groups = [NYC_AMS, NYC_SF, SF_AMS]
# groups = [EAST_WEST, WEST_EAST, NYC_AMS, NYC_SF, SF_AMS]
groups = [EAST_WEST, WEST_EAST]

cats.each do |cat|
  groups.each do |group|
    prefix = group[0]
    group_str = group[1..].join(' ')
    system("cd #{ROOT_DIR}; gnuplot -c parse_ping_data/plot_together.gp #{cat} '#{group_str}' #{prefix}") # rubocop:disable LineLength
  end
end
