# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_resource_simulator/version"

Gem::Specification.new do |s|
  s.name        = "active_resource_simulator"
  s.version     = ActiveResourceSimulator::VERSION
  s.authors     = ["Robert Lail"]
  s.email       = ["robert.lail@cph.org"]
  s.homepage    = ""
  s.summary     = %q{A smarter way of testing ActiveResource: a wrapper around HttpMock}
  s.description = %q{A wrapper around HttpMock}
  
  s.rubyforge_project = "active_resource_simulator"
  
  s.add_dependency "activeresource"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
