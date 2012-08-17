require 'bundler/setup'

require "minitest/autorun"
require "minitest/pride"

require 'cuesnap'
require 'rubycue'

# -------------
# Constants
# -------------

OUTPUT_FOLDER = File.expand_path("../../tmp/spec_output", __FILE__)

# -------------
# Helpers
# -------------
def cuesheet_fixture(name)
  if name && name.strip != ''
    fixture_path "#{name}.cue"
  else
    name
  end
end

def mp3_fixture(name)
  fixture_path "#{name}.mp3"
end

def fixture_path(name)
  File.join(File.dirname(__FILE__), "fixtures/#{name}")
end

def load_splitter(mp3_name, cuesheet_name)
  mp3 = mp3_fixture(mp3_name)
  cuesheet = cuesheet_fixture(cuesheet_name)

  @splitter = CueSnap::Splitter.new(mp3, cuesheet, {
    :quiet => true,
    :output_folder => "#{Time.now.to_i}#{rand(1000)}"
  })

end

# -------------
# Output Folder
# -------------

def cd_to_output
  FileUtils.mkdir_p OUTPUT_FOLDER unless File.exists? OUTPUT_FOLDER
  Dir.chdir OUTPUT_FOLDER
end

# Public: Get all of the mp3s in the output folder for the splitter.
def created_mp3s
  Dir.glob("#{@splitter.output_folder}/*.mp3").map { |f| File.basename f }
end

# Public: Adds after test suite callback to ensure temporary files are deleted.
class MyMiniTest
  class Unit < MiniTest::Unit
    def before_suites
    end

    def after_suites
      remove_mp3s
      remove_empty_directories
    end

    def remove_mp3s
      Dir.glob("#{OUTPUT_FOLDER}/**/*.mp3").each do |f|
        File.delete f unless File.directory? f
      end
    end

    def remove_empty_directories
      Dir.glob("#{OUTPUT_FOLDER}/*/").each { |d| Dir.delete d }
    end

    def _run_suites(suites, type)
      begin
        before_suites
        super(suites, type)
      ensure
        after_suites
      end
    end

    def _run_suite(suite, type)
      begin
        suite.before_suite if suite.respond_to?(:before_suite)
        super(suite, type)
      ensure
        suite.after_suite if suite.respond_to?(:after_suite)
      end
    end
  end
end

MiniTest::Unit.runner = MyMiniTest::Unit.new
