$:.unshift File.expand_path("../lib", __FILE__)
require 'mlatr/version'


Gem::Specification.new do |s|
  s.name        = 'mlatr'
  s.version     = Mlatr::VERSION
  s.summary     = "A Ruby library or gem for interacting with MLA format essays"
  s.description = s.summary
  s.authors     = ["Volodymyr Tsvang"]
  s.email       = 'vtsvang@gmail.com'
  s.homepage    = 'https://github.com/vtsvang/mlatr'
  s.files       = Dir["README.md", "LICENSE.md", "lib/**/*.rb"]
  s.license       = 'MIT'

  s.add_dependency 'rubyzip',  '~> 1.1.6'
  s.add_dependency 'nokogiri', '~> 1.5'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'exifr'
end