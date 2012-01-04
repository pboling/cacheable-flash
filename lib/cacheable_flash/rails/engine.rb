# Configure Rails 3.1:
#   This gem contains this empty engine class which inherits from Rails::Engine.
#   By doing this, Rails is informed that the directory for this gem may contain assets and the
#   app/assets, lib/assets and vendor/assets directories of this engine are added to the search path of Sprockets.
module CacheableFlash
  class Engine < ::Rails::Engine
  end
end
