dir = File.dirname(__FILE__)
require "#{dir}/../test_helper"

class InstallTest < Test::Unit::TestCase
  include FileUtils

  def setup
    @rails_root = "#{Dir.tmpdir}/cachable_flash_#{Time.now.to_f}"
    Object.send(:remove_const, :RAILS_ROOT) if Object.const_defined?(:RAILS_ROOT)
    Object.const_set(:RAILS_ROOT, @rails_root)

    @stdout = StringIO.new("")
    $stdout = @stdout

    @js_dir = "#{@rails_root}/public/javascripts"
    FileUtils.mkdir_p(@js_dir)
    @install_path = "#{File.dirname(__FILE__)}/../../install.rb"
  end

  def teardown
    $stdout = STDOUT
  end

  def test_install_without_json_js_file
    assert !File.exists?("#{@js_dir}/flash.js")
    assert !File.exists?("#{@js_dir}/json.js")
    assert !File.exists?("#{@js_dir}/cookie.js")
    load(@install_path)
    assert File.exists?("#{@js_dir}/flash.js")
    assert File.exists?("#{@js_dir}/json.js")
    assert File.exists?("#{@js_dir}/cookie.js")
  end

  def test_install_with_json_js_file
    File.open("#{@js_dir}/json.js", "w") do |f|
      f.write "Original json.js"
    end
    assert File.exists?("#{@js_dir}/json.js")
    assert !File.exists?("#{@js_dir}/flash.js")
    assert !File.exists?("#{@js_dir}/cookie.js")
    load(@install_path)
    assert File.exists?("#{@js_dir}/flash.js")
    assert File.exists?("#{@js_dir}/json.js")
    assert File.exists?("#{@js_dir}/cookie.js")
    assert_equal "Original json.js", File.read("#{@js_dir}/json.js")
  end

  def test_install_with_cookies_js_file
    File.open("#{@js_dir}/cookie.js", "w") do |f|
      f.write "Original cookie.js"
    end
    assert !File.exists?("#{@js_dir}/json.js")
    assert !File.exists?("#{@js_dir}/flash.js")
    assert File.exists?("#{@js_dir}/cookie.js")
    load(@install_path)
    assert File.exists?("#{@js_dir}/flash.js")
    assert File.exists?("#{@js_dir}/json.js")
    assert File.exists?("#{@js_dir}/cookie.js")
    assert_equal "Original cookie.js", File.read("#{@js_dir}/cookie.js")
  end
end