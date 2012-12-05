require 'methadone'
require 'pathname'
require 'open4'

module CueSnap
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    main do |mp3_file, cue_file|
      # no-numbers comes in false when it's set, I know, crazy.
      options[:no_numbers] = !options[:'no-numbers'] if options.has_key?(:'no-numbers')

			# If mp3splt isn't defined, tell the user how to install it and exit.
			unless command_accessible? 'mp3splt'
				exit_now! "mp3splt is required for cuesnap to function. Run `brew install mp3splt` to install it."
			end

      begin
        splitter = CueSnap::Splitter.new(mp3_file, cue_file, options)
      rescue FileNotFound => e
        file_not_found e.message
      rescue CueSnap::CueFileTooLarge => e
        help_now! e.message
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
      # Passing an empty block allows us to get the status as the return value.
      status = Open4::popen4("sh") do |pid, stdin, stdout, stderr|
        stdin.puts "which #{cmd}"
        stdin.close
      end
      # A 141 exit status means which succeeded.
      status.exitstatus == 141
		end

  end
end
