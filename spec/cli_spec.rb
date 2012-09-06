require File.expand_path('../spec_helper', __FILE__)
require 'open3'

describe CueSnap::CLI do
  describe 'When running the command line' do

    describe 'with no cue file argument' do
      it 'should tell the user when no .cue file is found' do
        stdin, stdout = Open3.popen3 'bin/cuesnap spec/fixtures/ten_minute.mp3'
        stdout.read.must_match(/I looked for .*ten_minute\.cue, but didn't find it\./)
      end
    end

    describe 'with missing .mp3 argument' do
      it "should tell the user when the specified mp3 isn't found" do
        stdin, stdout = Open3.popen3 'bin/cuesnap spec/fixtures/missing.mp3'
        stdout.read.must_match(/I looked for .*missing\.mp3, but didn't find it\./)
      end
    end

    describe 'with mp3 containing spaces and parenthesis' do
      it 'should not display a syntax error' do
        command = 'bin/cuesnap spec/fixtures/with\ spaces\ and\ \(\).mp3'
        stdin, stdout, stderr = Open3.popen3 command

        stderr.read.wont_match(/syntax error/)
      end
    end

  end

  describe 'When calling command_accessible?' do
    it 'with a missing executable, it should return false' do
      CueSnap::CLI.command_accessible?('missing_for_cuesnap').must_equal false
    end

    it 'with a present executable, it should return true' do
      CueSnap::CLI.command_accessible?('ls').must_equal true
    end
  end
end
