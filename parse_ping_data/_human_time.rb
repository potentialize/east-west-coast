#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative './each_file.rb'

each_file do |in_path, out_path|
  # NOTE: may override files at output location!
  in_file = File.open(in_path, 'r')
  out_file = File.open(out_path, 'w')

  # clean up
  in_file.close
  out_file.close
end
