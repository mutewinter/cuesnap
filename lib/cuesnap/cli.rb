require 'thor'

module CueSnap
  class CLI < Thor
    desc "MP3_FILE CUE_FILE", "Split an mp3 file into parts with the given cue file."
    method_option :no_spaces, aliases: "-ns",
    desc: "White space in file names, ARE YOU FUCKING INSANE?
      e.g. 02_Holy_Crap_-_So_Cool.mp3"
    def cut_it_up(mp3_file, cue_file)
      puts "You gave me music #{mp3_file} and text #{cue_file}"

      no_spaces = options[:no_spaces]
      if no_spaces
        puts "You don't want spaces? Fine."
      else
        puts "You do not want to delete #{file}"
      end
    end
  end
end
