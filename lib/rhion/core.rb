#require 'scorched'
require 'yaml'
require 'pp'

RHION_ROOT = ENV["RHION_ROOT"] ||= File.dirname(Rhion.first_caller) unless defined?(RHION_ROOT)

module Rhion
	
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