require 'rhion/caller'
require 'rhion/core'

module Rhion
  class << self
    def build!(options)
    	load_apps("bug")
      puts 'im build!', options
    end
  end
end