# -*- encoding: utf-8 -*-
require File.expand_path('../spec_helper', __FILE__)

describe CueSnap::Splitter do

  describe 'When splitting a using a cue file with unicode' do
    before do
      load_splitter 'ten_minute', 'unicode'
      cd_to_output
    end

    it 'the fourth track should be proper unicode' do
      skip 'Unicode support not yet added.'
      @splitter.split!
      created_mp3s[3].must_equal "4 Test Artist - Tësting Unicode"
    end

  end

  describe 'When splitting an ten_minute.mp3 with four_splits.cue' do
    before do
      load_splitter 'ten_minute', 'four_splits'
      cd_to_output
    end

    it 'splitting should produce 4 mp3 files' do
      created_mp3s.length.wont_equal 4
      @splitter.split!
      created_mp3s.length.must_equal 4
    end

    it 'the third track should not have a zero-padded index' do
      @splitter.split!
      created_mp3s[2].must_match(/^3/)
    end

    it 'it should have no numbers when no_numbers is specified' do
      @splitter.options.no_numbers = true
      @splitter.split!
      created_mp3s.first.must_equal 'Derp Man - 36 Second Track.mp3'
    end

  end

  describe 'When splitting ten_minute.mp3 and ten_splits.cue' do

    before do
      load_splitter 'ten_minute', 'ten_splits'
      cd_to_output
    end

    it 'must zero pad tracks less than 10th' do
      @splitter.split!
      created_mp3s.first.must_match(/^01/)
    end
  end

  describe 'When splitting same_name.mp3 without specified cuefile' do

    before do
      load_splitter 'same_name', nil
      cd_to_output
    end

    it 'should default to using same_name.cue' do
      File.basename(@splitter.cue_file).must_equal 'same_name.cue'
    end

  end

  describe 'when providing non-existant' do
    describe 'mp3 file' do
      it 'should throw an error' do
        assert_raises CueSnap::MP3FileNotFound do
          CueSnap::Splitter.new('missing_file.mp3')
        end
      end
    end

    describe 'cue file' do
      it 'should throw an error' do
        assert_raises CueSnap::CueFileNotFound do
          CueSnap::Splitter.new(mp3_fixture('ten_minute'), 'missing_file.cue')
        end
      end
    end
  end

  describe 'with spaces in the name of the' do
    describe 'mp3 file' do
      it 'should not raise an MP3FileNotFound exception' do
        begin
          CueSnap::Splitter.new(mp3_fixture('with spaces'))
        rescue CueSnap::MP3FileNotFound
          flunk 'Raised CueSnap::MP3FileNotFound exception'
        end
      end

      it 'should properly escape the spaces in the mp3 for mp3splt' do
        splitter = CueSnap::Splitter.new(mp3_fixture('with spaces'))
        File.basename(splitter.escaped_mp3_file).must_equal('with\ spaces.mp3')
      end

      it 'should properly escape the spaces in the output folder for mp3splt' do
        splitter = CueSnap::Splitter.new(mp3_fixture('with spaces'))
        splitter.escaped_output_folder.must_equal('with\ spaces')
      end

      it 'should split the mp3 into four files' do
        load_splitter 'with spaces', 'four_splits'
        cd_to_output

        created_mp3s.length.wont_equal 4
        @splitter.split!
        created_mp3s.length.must_equal 4
      end
    end

    describe 'cue file' do
      it 'should not raise an CueFileNotFound exception' do
        begin
          CueSnap::Splitter.new(mp3_fixture('ten_minute'),
                                cuesheet_fixture('with spaces'))
        rescue CueSnap::CueFileNotFound
          flunk 'Raised CueSnap::CueFileNotFound exception'
        end
      end

      it 'should properly escape the spaces in the cue file for mp3splt' do
        splitter = CueSnap::Splitter.new(mp3_fixture('ten_minute'),
                                         cuesheet_fixture('with spaces'))
        File.basename(splitter.escaped_cue_file).must_equal('with\ spaces.cue')
      end
    end
  end


  describe 'with parenthesis in the mp3 file name' do
    it 'should properly escape the parenthesis' do
      splitter = CueSnap::Splitter.new(mp3_fixture('with()'))
      File.basename(splitter.escaped_mp3_file).must_equal('with\(\).mp3')
    end
  end
end
