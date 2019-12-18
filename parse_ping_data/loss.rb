#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'each_file.rb'

each_file('loss') do |path_in, path_out|
  system("cd #{ROOT_DIR}; awk -f parse_ping_data/loss.awk #{path_in} > #{path_out}") # rubocop:disable LineLength
end
