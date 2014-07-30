require 'rhino/project'
require 'pp'
require 'thor'


module Rhino
  module Project
    class Config
      include Thor::Actions

      def initialize
        puts '@app_name: ' + Rhino::Project.app_name.to_s
        #pp Rhino::Project.get_yaml
      end

    end
  end
end