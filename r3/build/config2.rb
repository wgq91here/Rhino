require 'build/init2'

module Rhino
    class Config
      class << self
        include Rhino::Build
      end

      def initialize(struct)
        @struct = struct
        puts 'init', struct
      end

      def wu
        puts self.Test
        #self.init @struct
        #puts self.getMe
      end
    end
end
