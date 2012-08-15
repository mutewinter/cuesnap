# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cuesnap/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Jeremy Mack']
  s.email         = ['jeremy@pileofturtles.com']
  s.description   = %q{A command line tool for splitting mp3s with cue files}
  s.summary       = %q{Easily build JavaScript projects}
  s.homepage      = "http://github.com/mutewinter/cuesnap"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "cuesnap"
  s.require_paths = ["lib"]
  s.version       = CueSnap::VERSION

  # Regular Gems
  s.add_dependency 'rubycue', '~> 0.1.0'
  s.add_dependency 'thor', '~> 0.15.4'
  s.add_dependency 'hashie', '~> 1.2.0'

  # Development Gems
  s.add_development_dependency 'minitest', '~> 3.3.0'
  s.add_development_dependency 'guard-minitest', '~> 0.5.0'
end
