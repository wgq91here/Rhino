#require 'scorched'
require 'yaml'
require 'pp'

Rhino_ROOT = ENV["Rhino_ROOT"] ||= File.dirname(Rhino.first_caller) unless defined?(Rhino_ROOT)

module Rhino
	
	def self.load_apps(appName)
		yamlFile = "apps/#{appName}/#{appName}.yaml"
	  yaml = YAML.load(File.open(yamlFile))
	  pp yaml
  end

  def self.list_apps
  	@Apps
  end

  def self.reload!
  	@Apps = Dir.glob(File.join("apps/*",""))
  end

  class << self
  end
end