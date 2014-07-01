require 'rhino'
require 'thor'

module Rhino
  class Cli < Thor
    class_option :chdir, :type => :string, :aliases => '-c', :desc => 'Change to dir before starting.'
    class_option :environment, :type => :string, :aliases => '-e', :required => true, :default => :development, :desc => 'Rhino Environment.'
    class_option :help, :type => :boolean, :desc => 'Show help usage'
    class_option :version, :desc => 'Show version'

    desc 'project', 'Build project by YAML.'
    long_desc <<-LONGDESC
    `cli hello` will print out a message to a person of your
    choosing.

    You can optionally specify a second parameter, which will print
    out a from message as well.

    > $ cli hello "Yehuda Katz" "Carl Lerche"

    > from: Carl Lerche
    LONGDESC
    map '-p' => :project
    method_option :yaml, :type => :string, :required => true, :default => :app, :desc => 'Build project by Yaml file.'

    def project
      say '=>'+' ' *6 + Rhino.version
      require 'rhino/project'
      Rhino::Project.app_name = options['yaml']
      Rhino::Project.components = {}
      #puts Rhino::Project.project_yaml_file
      #puts Rhino::Project.get_yaml
      puts Rhino::Project.register(:config, Rhino::Project::Config.new)
      puts Rhino::Project.app_name
      puts Rhino::Project.components
      #puts Rhino::Project.components
      puts Rhino::Project.instance_variables

      #puts Rhino::Project::Config.new

      #require File.expand_path('../build/init', __FILE__)
      #build = Rhino::Build::Init.new options
      #require 'pp'
      #pp build.getStruct
      #build.register('config')
      #pp build.get_factory 'config'
      #pp build.get_factory 'config'
    end

    desc 'patch', 'Patch exist project by changed yaml'
    long_desc <<-LONGDESC
    ReWrite some code by changed Yaml.
    LONGDESC

    def patch

    end

    desc 'version', 'Show Rhino version.'

    def version
      say 'Rhino version: ' + Rhino.version
    end
  end
end
