require 'rhino/caller'
require 'rhino/core'

module Rhino
  module Generators
    class Build
        def self.start(options)
          puts 'im build!', options["yaml"]
          #load_apps(options["yaml"])
        end
    end
  end
end