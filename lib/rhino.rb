require 'rhino/caller'
require 'rhino/core'

module Rhino
  class << self
    def build!(options)
      puts 'im build!', options["yaml"]
    	load_apps(options["yaml"])
    end
  end
end