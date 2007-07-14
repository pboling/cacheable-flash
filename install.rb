require 'fileutils'
include FileUtils

dir = "#{File.dirname(__FILE__)}/javascripts"
rails_javascripts_dir = "#{RAILS_ROOT}/public/javascripts"

puts "copying flash.js to #{rails_javascripts_dir}"
cp "#{dir}/flash.js", rails_javascripts_dir
if File.exists?("#{rails_javascripts_dir}/json.js")
  puts "#{rails_javascripts_dir}/json.js already exists"
else
  puts "copying json.js to #{rails_javascripts_dir}"
  cp "#{dir}/json.js", rails_javascripts_dir
end

if File.exists?("#{rails_javascripts_dir}/cookies.js")
  puts "#{rails_javascripts_dir}/cookies.js already exists"
else
  puts "copying cookies.js to #{rails_javascripts_dir}"
  cp "#{dir}/cookies.js", rails_javascripts_dir
end
