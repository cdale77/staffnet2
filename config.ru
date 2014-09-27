# This file is used by Rack-based servers to start the application.
require "gctools/oobgc"

require ::File.expand_path("../config/environment",  __FILE__)
GC::OOB.run # after every request
use(GC::OOB::UnicornMiddleware) # in config.ru for unicorn
run Rails.application
