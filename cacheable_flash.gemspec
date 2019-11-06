# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cacheable_flash/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "cacheable_flash"
  s.version = CacheableFlash::VERSION

  s.authors = ["Peter H. Boling", "Brian Takita"]
  s.description = "Allows caching of pages with flash messages by rendering flash\nmessages from a cookie using JavaScript, instead of statically in your Rails\nview template.  Flash contents are converted to JSON and placed in\na cookie by an after_filter (default) or a Rack Middleware (option)."
  s.email = "peter.boling@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.homepage = "http://github.com/pboling/cacheable-flash"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.summary = "Render flash messages from a cookie using JavaScript, instead of in your Rails view template"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<stackable_flash>, [">= 0.0.7"])
  s.add_runtime_dependency(%q<json>, [">= 0"])
  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "rake", "~> 12.3"
  s.add_development_dependency(%q<rails>, ["~> 6.0.1"])
  s.add_development_dependency(%q<jquery-rails>, [">= 0"])
  s.add_development_dependency(%q<rspec-rails>, [">= 3.3.3"])
  s.add_development_dependency(%q<rdoc>, [">= 3.12"])
  s.add_development_dependency(%q<reek>, [">= 3.5.0"])
  s.add_development_dependency(%q<roodi>, [">= 5.0.0"])
end
