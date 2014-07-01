require 'yaml'

module Rhino
  module Util
    def self.yaml(yaml_file)
      yaml = YAML.load(File.open(yaml_file)) if File.exist?(yaml_file)
      yaml || {}
    end
  end
end