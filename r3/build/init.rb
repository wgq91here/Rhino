require 'thor'
require 'yaml'
require 'rhino'

module Rhino
  module Build
    class Init
      def initialize(options)
        options.symbolize_keys!
        @struct = {
            :environment => :development,
            :options => {},
            :app => 'app',
            :struct => {}
        }
        @factory = {}
        @struct[:options] = options
        @struct[:app] = options['yaml']
        puts 'App : '+ @struct[:app]
        app_struct(@struct[:app])
      end

      def getStruct
        @struct
      end

      def register(factory_name)
        require 'build/' + factory_name
        puts "Rhino::Build::#{factory_name.capitalize}.new"
        @factory[factory_name.to_s] = eval("Rhino::Build::#{factory_name.capitalize}.new @struct")
      end

      def get_factory(name)
        return @factory[name.to_s]
      end

      private
      def app_struct(app_name)
        yaml_file = "apps/#{app_name}/#{app_name}.yaml"
        @struct[:struct] = YAML.load(File.open(yaml_file))
      end
    end
  end
end