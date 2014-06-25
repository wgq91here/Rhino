require 'rhino/caller'
require 'rhino/core'

module Rhino
  class << self
    def build!(options)
    	load_apps("bug")
      puts 'im build!', options
    end
  end
end