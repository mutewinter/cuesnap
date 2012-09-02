require 'methadone'
require 'pathname'

module CueSnap
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    main do |mp3_file, cue_file|
      # no-numbers comes in false when it's set, I know, crazy.
      options[:no_numbers] = !options[:'no-numbers'] if options.has_key?(:'no-numbers')

			# Check if mp3splt is accessible else exit
			if (!command_accessible?('mp3splt'))
				exit_now! "I looked for mp3splt but couldn't find it. Perhaps you need to install it."
			end

      begin
        splitter = CueSnap::Splitter.new(mp3_file, cue_file, options)
      rescue FileNotFound => e
        file_not_found e.message
      end

      if File.exists? splitter.cue_file
        begin
          splitter.split!
        rescue Iconv::IllegalSequence => e
          exit_now! "Unicode isn't quite working yet, sorry. Strip it out of your .cue file for a temporary fix."
        end
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

		def self.command_accessible?(cmd)
			ENV['PATH'].split(':').each do |folder|
				exists = File.exists?(folder + '/' + cmd)
				exec = File.executable?(folder + '/' + cmd) if exists
				return true if exec
			end
			return false;
		end

  end
end
