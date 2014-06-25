require 'rhino'
require 'thor'

module Rhino
  module Build
    class Cli < Thor
      class_option :chdir, :type => :string, :aliases => '-c', :desc => 'Change to dir before starting.'
      class_option :environment, :type => :string, :aliases => '-e', :required => true, :default => :development, :desc => 'Rhino Environment.'
      class_option :help, :type => :boolean, :desc => 'Show help usage'

      desc 'build', 'Build project by YAML.'
      map '-b' => :build
      method_option :yaml, :type => :string, :required => true, :default => :app, :desc => 'Build by Yaml file.'

      def build
        # implement git remote add
        say '=>'+' ' *6 + Rhino.version
        require File.expand_path('../build/init', __FILE__)
        build = Rhino::Build::Init.new options
        require 'pp'
        pp build.getStruct
        build.register('config')
        pp build.get_factory 'config'
        pp build.get_factory 'config'
      end
    end
  end
end