require 'rhino/util'
require 'rhino/project/config'

module Rhino
  module Project
    class << self
      #include Rhino::Util
      attr_accessor :app_name,:app_name1, :components

      def register(name, option)
        @components.store(name.to_s, option)
      end
    end

    autoload :Config, 'rhino/config'

    def self.project_yaml_file
      "apps/#{@app_name}/#{@app_name}.yaml" if @app_name != ''
    end

    def self.get_yaml
      Rhino::Util.yaml(project_yaml_file)
    end

  end
end