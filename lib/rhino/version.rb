module Rhino
  RHINO_VERSION = '0.0.1' unless defined?(Rhino::RHINO_VERSION)

  class << self
    def version
      RHINO_VERSION
    end
  end
end