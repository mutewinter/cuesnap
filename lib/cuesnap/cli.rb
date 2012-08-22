require 'methadone'
require 'pathname'

require 'cuesnap/splitter'

module CueSnap
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    main do |mp3_file, cue_file|
      # no-numbers comes in false when it's set, I know, crazy.
      options[:no_numbers] = !options[:'no-numbers'] if options.has_key?(:'no-numbers')

      file_not_found mp3_file unless File.exists? mp3_file

      begin
        splitter = CueSnap::Splitter.new(mp3_file, cue_file, options)
      rescue FileNotFound => e
        file_not_found e.message
      end

      if File.exists? splitter.cue_file
        splitter.split!
      else
        file_not_found splitter.cue_file
      end

    end

    on('--no-numbers')
    on('-q', '--quiet')

    version     CueSnap::VERSION
    description 'Snapping MP3s with cue sheets faster than your mom pops Pringle tops.'

    arg :mp3_file
    arg :cue_file, :optional

    def self.file_not_found(file)
      help_now! "I looked for #{file}, but didn't find it."
    end
  end
end
