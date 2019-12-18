#!/usr/bin/env ruby

# frozen_string_literal: true

require 'fileutils'

# dirs
ROOT_DIR = File.join(File.dirname(__FILE__), '..')

def each_file(label = nil) # rubocop:disable MethodLength
  in_dir = File.join(ROOT_DIR, 'ping_data', 'final')
  out_dir = File.join(ROOT_DIR, 'ping_data', label) unless label.nil?

  # make sure out path exists
  FileUtils.mkpath(out_dir) unless label.nil? || File.directory?(out_dir)

  Dir.foreach(in_dir) do |file|
    in_path = File.join(in_dir, file)

    next if File.directory?(in_path)

    ext = File.extname(in_path)

    next unless ext == '.txt'

    out_path = File.join(out_dir, file) unless label.nil?

    yield(in_path, out_path)
  end
end
