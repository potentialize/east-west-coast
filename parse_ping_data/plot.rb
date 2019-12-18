#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './each_file.rb'

each_file do |path_in|
  name = File.basename(path_in)

  prefix = 'full-range'

  cats = ['avg100']

  cats.each do |cat|
    system("cd #{ROOT_DIR}; gnuplot -c parse_ping_data/plot.gp #{cat} #{name} #{prefix}") # rubocop:disable LineLength
  end
end
