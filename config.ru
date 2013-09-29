# This file is used by Rack-based servers to start the application.

# unicorn gc stuff
GC_FREQUENCY = 5
require 'unicorn/oob_gc'
GC.disable # Don't run GC during requests
use Unicorn::OobGC, GC_FREQUENCY # Only GC once every GC_FREQUENCY requests

require ::File.expand_path('../config/environment',  __FILE__)
run AnimalTracker::Application
