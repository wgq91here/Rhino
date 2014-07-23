require 'rhino/project'
require 'pp'

module Rhino
  module Project
    class Config

      def initialize
        puts '@app_name: ' + Rhino::Project.app_name.to_s
        pp Rhino::Project.get_yaml
      end
    end
  end
end