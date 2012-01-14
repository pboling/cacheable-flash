# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "cacheable_flash"
  gem.homepage = "http://github.com/pivotal/cacheable-flash"
  gem.license = "MIT"
  gem.summary = %Q{Render flash messages from a cookie using JavaScript, instead of in your Rails
view template}
  gem.description = %Q{This plugin enables greater levels of page caching by rendering flash
messages from a cookie using JavaScript, instead of in your Rails
view template.  Flash contents are converted to JSON and placed in
a cookie by an after_filter in a controller.}
  gem.email = "peter.boling@gmail.com"
  gem.authors = ["Peter H. Boling","Brian Takita"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.verbose = false
  t.source_files = 'lib/**/*.rb'
end

require 'roodi'
require 'roodi_task'
RoodiTask.new do |t|
  t.verbose = false
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
