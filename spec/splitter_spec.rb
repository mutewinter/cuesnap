# -*- encoding: utf-8 -*-
require File.expand_path('../spec_helper', __FILE__)

describe CueSnap::Splitter do

  describe 'When testing small_unicode.mp3 / cue' do

    before do
      load_splitter 'small_unicode'
    end

    it 'splitter should contain 4 tracks' do
      @splitter.track_names.length.must_equal 4
    end

    it 'the fourth track should be proper unicode' do
      @splitter.track_names[3].must_equal "Tësting Unicode"
    end

    it 'the third track should begin without zero-padded index' do
      @splitter.track_names[2].must_match(/^3/)
    end

    it 'splitting should produce 4 mp3 files' do
      # Ensure the directory is empty before we start.
      Dir.glob("#{@output_folder}.mp3").length.wont_equal 4

      @splitter.split!(@output_folder)

      # Alright, now those new mp3 files should be there.
      Dir.glob("#{@output_folder}.mp3").length.must_equal 4
    end

  end

  describe 'When testing large_unicode.mp3 / cue' do

    before do
      load_splitter 'large_unicode'
    end

    it 'must zero pad tracks less than 10th' do
      @splitter.track_names[2].must_match(/^0#{3}/)
    end
  end

end
