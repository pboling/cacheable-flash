class ComparisonController < ApplicationController

  include CacheableFlash

  def single_key_string
    flash[:notice] = 'message'
    render :text => 'Foo'
  end

  def single_key_array
    flash[:notice] = ['message']
    render :text => 'Foo'
  end

  def single_key_hash
    flash[:notice] = {:hello => 'asdf'} # NOTE: Keys of hashes are always strings on the other side of JSON
    render :text => 'Foo'
  end

  def single_key_number
    flash[:notice] = 1
    render :text => 'Foo'
  end

end
