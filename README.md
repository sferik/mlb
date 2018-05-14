# MLB.rb

[![Gem Version](http://img.shields.io/gem/v/gems.svg)][gem]
[![Build Status](http://img.shields.io/travis/sferik/gems.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/sferik/gems.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/sferik/gems.svg)][codeclimate]
[![Coverage Status](http://img.shields.io/coveralls/sferik/gems.svg)][coveralls]

[gem]: https://rubygems.org/gems/mlb
[travis]: http://travis-ci.org/sferik/mlb
[gemnasium]: https://gemnasium.com/sferik/mlb
[codeclimate]: https://codeclimate.com/github/sferik/mlb
[coveralls]: https://coveralls.io/r/sferik/mlb

MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.

## Installation
    gem install mlb

## Documentation
[http://rdoc.info/gems/mlb][documentation]

[documentation]: http://rdoc.info/gems/mlb

## Usage Examples
    $ irb
    >> require 'mlb'
    >> MLB::Team.all.first.name                   # => "Arizona Diamondbacks"
    >> MLB::Team.all.first.league                 # => "National League"
    >> MLB::Team.all.first.division               # => "National League West"
    >> MLB::Team.all.first.manager                # => "Bob Melvin"
    >> MLB::Team.all.first.wins                   # => 82
    >> MLB::Team.all.first.losses                 # => 80
    >> MLB::Team.all.first.founded                # => 1998
    >> MLB::Team.all.first.mascot                 # => nil
    >> MLB::Team.all.first.ballpark               # => "Chase Field"
    >> MLB::Team.all.first.logo_url               # => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/en_id/13104064"
    >> MLB::Team.all.first.players.first.name     # => "Alex Romero"
    >> MLB::Team.all.first.players.first.number   # => 28
    >> MLB::Team.all.first.players.first.position # => "Right fielder"

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.3
* Ruby 2.0.0
* Ruby 2.1.0
* [Rubinius][]
* [JRuby][]

[rubinius]: http://rubini.us/
[jruby]: http://jruby.org/

If something doesn't work on one of these interpreters, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.

## Colophon
MLB was built with the following tools:

* [Bundler][]
* [Faraday][]
* [Markdown][]
* [MultiJSON][]
* [RSpec][]
* [SimpleCov][]
* [SQLite][]
* [vim][]
* [WebMock][]
* [YARD][]

[bundler]: http://gembundler.com/
[faraday]: https://github.com/technoweenie/faraday
[markdown]: http://daringfireball.net/projects/markdown/
[multijson]: https://github.com/intridea/multi_json
[rspec]: http://relishapp.com/rspec/
[simplecov]: https://github.com/colszowka/simplecov
[sqlite]: http://www.sqlite.org/
[vim]: http://www.vim.org/
[webmock]: https://github.com/bblimke/webmock
[yard]: http://yardoc.org/

## Copyright
Copyright (c) 2010-2013 Erik Michaels-Ober. See [LICENSE][] for details.

[license]: LICENSE.md
