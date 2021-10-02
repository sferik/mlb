# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mlb/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'faraday_middleware', '~> 1.0'
  spec.author = 'Erik Michaels-Ober'
  spec.description = 'MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.'
  spec.email = 'sferik@gmail.com'
  spec.files = %w(.yardopts CONTRIBUTING.md LICENSE.md README.md mlb.gemspec) + Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/sferik/mlb'
  spec.licenses = %w(MIT)
  spec.name = 'mlb'
  spec.require_paths = %w(lib)
  spec.required_ruby_version = '>= 1.9.3'
  spec.summary = spec.description
  spec.version = MLB::Version
end
