# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jumbled-rspec-formatter/version"

Gem::Specification.new do |s|
  s.name        = "jumbled-rspec-formatter"
  s.version     = Jumbled::Rspec::Formatter::VERSION
  s.authors     = ["Richard W. Norton"]
  s.email       = ["rwtnorton@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Jumbles text of spec output}
  s.description = %q{Jumbles text of spec output}

  s.rubyforge_project = "jumbled-rspec-formatter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec', '~> 2'
end
