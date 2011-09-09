# Only executed when installed as plugin.
# When installed as a gem must use the generator
require 'fileutils'
include FileUtils

dir = "#{File.dirname(__FILE__)}/javascripts"
rails_javascripts_dir = "#{RAILS_ROOT}/public/javascripts"

puts "copying flash.js to #{rails_javascripts_dir}"
cp "#{dir}/flash.js", rails_javascripts_dir

if File.exists?("#{rails_javascripts_dir}/jquery.cookie.js")
  puts "#{rails_javascripts_dir}/jquery.cookie.js already exists"
else
  puts "copying jquery.cookie.js to #{rails_javascripts_dir}"
  cp "#{dir}/jquery.cookie.js", rails_javascripts_dir
end
