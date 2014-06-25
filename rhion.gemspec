# encoding: utf-8

require File.expand_path("../lib/version/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rhino'
  s.version     = '0.0.1'
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "Generate web ruby app by yaml"
  s.description = "Generate web ruby app"
  s.required_rubygems_version = ">= 1.3.6"
  s.authors     = ["Fred Wu"]
  s.email       = 'wgq91here@gmail.com'
  s.files       = ["lib/Rhion.rb"]
  s.homepage    = 'http://rhino.91here.com'
  s.license     = 'Apache 2.0'

  s.files         = Dir.glob(`git ls-files`.split("\n") - %w[.gitignore])
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("scorched")
end