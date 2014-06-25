#require 'scorched'
#require 'pp'
require 'yaml'


Rhino_ROOT = ENV['Rhino_ROOT'] ||= File.dirname(Rhino.first_caller) unless defined?(Rhino_ROOT)

module Rhino
	
	def self.load_apps(appName)
		yamlFile = "apps/#{appName}/#{appName}.yaml"
	  YAML.load(File.open(yamlFile))
  end

  def self.list_apps
  	@Apps
  end

  def self.reload!
  	@Apps = Dir.glob(File.join('apps/*',''))
  end

  class << self
  end
end