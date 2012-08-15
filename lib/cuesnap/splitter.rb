require 'hashie'

module CueSnap
  class Splitter
    # Public: Loads an mp3 and a RubyCue cuesheet.
    #
    # mp3_file  - String file path to an mp3 file.
    # cue_file  - The path to a cuesheet for the target cue file.
    # options   - Hash of options.
    #             no_numbers - No number prefix for tracks.
    #             output_folder - The output folder to use (default: the name
    #               of the mp3).
    #
    # Returns the initalized object.
    def initialize(mp3_file, cue_file, options = {})
      @cue_file = cue_file
      @mp3_file = mp3_file

      @options = Hashie::Mash.new options
      @output_folder ||= @options.output_folder

      unless cue_file.instance_of? RubyCue::Cuesheet
        file_contents = File.read cue_file
        file_contents.encode!('UTF-8', 'UTF-8', invalid: :replace)
        @cuesheet = RubyCue::Cuesheet.new file_contents
        @cuesheet.parse!
      end
    end

    # Public: Splits the mp3 into files based on track_names and saves them to
    # the output folder.
    #
    # Returns nothing.
    def split!
      format = "@p - @t"

      song_count_length = (@cuesheet.songs.length + 1).to_s.length
      number_format = "@N#{song_count_length > 1 ? song_count_length : ''}"
      format = "#{number_format} #{format}" unless @options.no_numbers

      # Got to esape the spaces for the shell
      format.gsub!(/\s/, '\\ ')

      command = ['mp3splt',
                 "-d #{output_folder}",
                 "-o #{format}",
                 "-c #@cue_file"]
      command.push '-Q' if @options.quiet
      command.push @mp3_file

      system command.join(' ')
    end

    attr_reader :mp3_file, :cue_file, :output_folder, :options

  end
end
