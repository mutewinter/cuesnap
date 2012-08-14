require 'bundler/setup'

require "minitest/autorun"
require "minitest/pride"

require 'cuesnap'
require 'rubycue'

def cuesheet_fixture(name)
  fixture_path "#{name}.cue"
end

def mp3_fixture(name)
  fixture_path "#{name}.mp3"
end

def fixture_path(name)
  File.join(File.dirname(__FILE__), "fixtures/#{name}")
end

def load_splitter(name)
  cuesheet = cuesheet_fixture(name)
  mp3 = mp3_fixture(name)

  @output_folder = File.expand_path('../../tmp/spec_output/', __FILE__)

  FileUtils.mkdir @output_folder unless File.exists? @output_folder

  puts "Using output folder #{@output_folder}"
  @splitter = CueSnap::Splitter.new(mp3, cuesheet)
end
