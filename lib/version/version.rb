module Rhion
  # The version constant for the current version of Rhion.
  VERSION = '0.0.1' unless defined?(Rhion::VERSION)

  #
  # The current Rhion version.
  #
  # @return [String]
  #   The version number.
  #
  def self.version
    VERSION
  end
end # Rhion
