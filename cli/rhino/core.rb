require 'yaml'

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

end
