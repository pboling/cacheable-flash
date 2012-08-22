# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cacheable_flash/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "cacheable_flash"
  s.version = CacheableFlash::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter H. Boling", "Brian Takita"]
  s.date = "2012-08-13"
  s.description = "Allows caching of pages with flash messages by rendering flash\nmessages from a cookie using JavaScript, instead of statically in your Rails\nview template.  Flash contents are converted to JSON and placed in\na cookie by an after_filter (default) or a Rack Middleware (option)."
  s.email = "peter.boling@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = "http://github.com/pivotal/cacheable-flash"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Render flash messages from a cookie using JavaScript, instead of in your Rails view template"

  s.add_runtime_dependency(%q<stackable_flash>, [">= 0.0.7"])
  s.add_runtime_dependency(%q<json>, [">= 0"])
  s.add_development_dependency(%q<rails>, ["~> 3.1.3"])
  s.add_development_dependency(%q<jquery-rails>, [">= 0"])
  s.add_development_dependency(%q<rspec-rails>, [">= 2.11.0"])
  s.add_development_dependency(%q<rdoc>, [">= 3.12"])
  s.add_development_dependency(%q<reek>, [">= 1.2.8"])
  s.add_development_dependency(%q<roodi>, [">= 2.1.0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
end
