require 'cuesnap'

require 'methadone'
module CueSnap
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    main do |mp3_file, cue_file|
      # no-numbers comes in false when it's set, I know, crazy.
      options[:no_numbers] = !options[:'no-numbers'] if options.has_key?(:'no-numbers')

      CueSnap::Splitter.new(mp3_file, cue_file, options).split!
    end

    on('--no-numbers')
    on('-q', '--quiet')

    arg :mp3_file
    arg :cue_file, :optional
  end
end
