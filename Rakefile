require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

PKG_VERSION = "0.1.2"

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the cacheable_flash plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the cacheable_flash plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'CacheableFlash'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Tag the current release'
task(:tag_release) {tag_release}

def tag_release
  dashed_version = PKG_VERSION.gsub('.', '-')
  user = ENV['USER'] || nil
  user_part = user ? "#{user}@" : ""
  svn_path = "svn+ssh://#{user_part}rubyforge.org/var/svn/pivotalrb/cacheable_flash"
  `svn cp #{svn_path}/trunk #{svn_path}/tags/REL-#{dashed_version} -m 'Version #{PKG_VERSION}'`
end