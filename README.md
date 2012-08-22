# CueSnap

Snapping MP3s with [cue sheets][1] faster than your mom pops Pringle tops.

[1]: http://en.wikipedia.org/wiki/Cue_sheet_%28computing%29

## Setup

_Tested on Mac OS X 10.7 (Lion)._

**Prerequisites**

 1. [Mac OS X](http://store.apple.com)
 1. [Homebrew](http://mxcl.github.com/homebrew/)
 1. [Ruby 1.8.7 or Greater](http://ruby-lang.org/) _Comes pre-installed in OS X_

**Okay, let's go**

 1. `brew install mp3splt` _Install the mp3 clipping lbrary, it does the heavy-lifting._
 1. `sudo gem install cuesnap` _The cuesnap command will now be available._
 1. `cuesnap phattrack.mp3 phattrack.cue` _*snap -- zzrgt -- crack*_
 1. `open phattrack` _Gaze into the eyes of your slim mp3 files_

## Usage

**Run**

`cuesnap supercool_but_so_large.mp3 supercool.cue`

**and you get**

```
  supercool_but_so_large\
    |
    |- 01 Intro.mp3
    |- 02 Holy Crap - So Cool.mp3
    |- 03 Slower Crap - Pretty Coo.mp3
    |- 04 It's On - Like Donkey Kong.mp3
```

## Command Line Options

```
  --no-numbers (-nn) -
    Because, fuck sorting.
      e.g. Holy Crap - So Cool.mp3
  -q, --quiet
    Shut the hell up cuensap. Just be quiet.
```

## Setup for Development

 1. Follow the steps in the **Setup** section.
 1. `git clone http://github.com/mutewinter/cuesnap` _Clone this repo, duh._
 1. `cd cuesnap` _Change directory into the folder._
 1. `bundle` _Setup those pretty Ruby gems._

 That's it, now code something awesome and tell me about it.

## Changelog

### 1.1.1

 * Now properly escaping shell characters found in file names

## Todo

 1. Unicode Support _Fail test is already in_.
 1. Error Message when mp3splt is missing.

## Contributing

1. [Fork it](https://github.com/mutewinter/cuesnap/fork_select).
1. Create your feature branch (`git checkout -b my_sweet_feature`).
1. Write some kickass code.
1. Commit your changes (`git commit -am 'Added a sweet feature'`).
1. Push to the branch (`git push origin my_sweet_feature`).
1. Create new [Pull Request](https://github.com/mutewinter/cuesnap/pulls).
