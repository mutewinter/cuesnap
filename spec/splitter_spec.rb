# -*- encoding: utf-8 -*-
require File.expand_path('../spec_helper', __FILE__)

describe CueSnap::Splitter do

  describe 'When splitting a using a cue file with unicode' do
    before do
      load_splitter 'ten_minute', 'unicode'
      cd_to_output
    end

    it 'the fourth track should be proper unicode' do
      @splitter.split!
      created_mp3s[3].must_equal "Tësting Unicode"
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
      # FIXME failing test
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

end
