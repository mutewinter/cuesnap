module CueSnap
  class Splitter
    # Public: Loads an mp3 and a RubyCue cuesheet.
    #
    # mp3_file - String file path to an mp3 file.
    # cuesheet - RubyCue::Cuesheet object or the path to a cuesheet for the
    #            target cue file.
    #
    # Returns the initalized object.
    def initialize(mp3_file, cuefile)
      unless cuefile.instance_of? RubyCue::Cuesheet
        file_contents = File.read cuefile
        file_contents.encode!('UTF-8', 'UTF-8', invalid: :replace)
        @cuesheet = RubyCue::Cuesheet.new file_contents
        @cuesheet.parse!
      end
      @mp3_file = mp3_file
    end

    # Public: Splits the mp3 into files based on track_names and saves them to
    # the output folder.
    #
    # output_folder - The folder where the mp3s will be saved (default: the mp3
    #                 name)
    #
    # Returns nothing.
    def split!(output_folder = nil)
      output_folder ||= File.dirname(__FILE__)

    end

    # Public: Returnsk
    def track_names
      song_count = @cuesheet.songs.length + 1

      @cuesheet.songs.map do |song|
        track = song[:track]
        track = track.to_s.rjust(song_count.to_s.length, '0')
        "#{track} #{song[:performer]} - #{song[:title]}"
      end
    end

  end
end
