require File.expand_path('../spec_helper', __FILE__)

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
  end
end
