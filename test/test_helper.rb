require "rubygems"
require "test/unit"
require "json"
require "mocha"
require "tmpdir"
require "fileutils"

dir = File.dirname(__FILE__)
$LOAD_PATH << "#{dir}/../lib"
require "cacheable_flash"
