require 'rhino/caller'
require 'rhino/core'

module Rhino
  module Generators
    module Build
      #class << self
        def build!(options)
          say 'im build!', options["yaml"]
          load_apps(options["yaml"])
        end
      #end
    end
  end
end