require 'thor'
require 'cuesnap'

module CueSnap
  class CLI < Thor
    desc "MP3_FILE CUE_FILE", "Split an mp3 file into parts with the given cue file."
    method_option :no_numbers, aliases: "-nn",
    desc: "Because, fuck sorting.
      e.g. Holy Crap - So Cool.mp3"
    def cut(mp3_file, cue_file)
      CueSnap::Splitter.new(mp3_file, cue_file, options).split!
    end
    default_task :cut
  end
end
