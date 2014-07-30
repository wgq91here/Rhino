# encoding: utf-8

require 'rhino'
require 'thor'
require 'pp'
require 'logger'

RHINO_LOGGER = {:staging => {:log_level => :debug, :stream => :stdout}}

module Rhino
  module CLI
    class Project < Cli
      include Thor::Actions

      class_option :env,
                   :type => :string,
                   :enum => %w(development product test),
                   :aliases => '-e',
                   :desc => 'Rhino Environment.'

      #
      #
      #
      desc 'show', 'List project component\'s info.'
      map '-l' => :list
      method_option :app,
                    :type => :string,
                    :required => true,
                    :desc => 'Given project\'s names.'
      method_option :component,
                    :type => :array,
                    :default => %w(config auth data event theme),
                    :desc => 'Given component\'s names.'

      def show
        pp options
        run(destination_root + '/bin/rhino component test' + ' --app ' + options['app'].to_s + ' --env=' + options['env'].to_s)
      end

      #
      #
      #
      desc 'export', 'Export project info by Yaml.'
      method_option :app,
                    :type => :string,
                    :aliases => '-a',
                    :required => true,
                    :desc => 'Given app name.'
      method_option :out,
                    :type => :string,
                    :aliases => '-o',
                    :default => '.',
                    :desc => 'Given yaml file path.'

      def export
        pp options
        #Rhino::Component.start(ARGV)
      end

      #
      #
      #
      desc 'import', 'Import project info by Yaml.'
      method_option :yaml,
                    :type => :string,
                    :aliases => '-y',
                    :required => true,
                    :default => :app,
                    :desc => 'Build project by Yaml file.'
      method_option :generate,
                    :aliases => '-g',
                    :type => :boolean,
                    :default => false,
                    :desc => 'Generate project files by Yaml file.'

      def import
        pp options
        printVersion
        printAction '[Project Import]'
        require 'rhino/project'
        Rhino::Project.app_name = options['yaml']
        Rhino::Project.components = {}
        #Rhino.logger.info(Rhino::Project.get_yaml)
        Rhino.logger.info('Loading yaml filename: ['+ Rhino::Project.project_yaml_file.colorize(:yellow) + ']')
        #puts Rhino::Project.get_yaml
        Rhino::Project.register(:config, Rhino::Project::Config.new)
        #pp Rhino::Project.app_name
        #pp Rhino::Project.components
        #pp Rhino::Project.instance_variables


        #puts Rhino::Project::Config.new

        #require File.expand_path('../build/init', __FILE__)
        #build = Rhino::Build::Init.new options
        #require 'pp'
        #pp build.getStruct
        #build.register('config')
        #pp build.get_factory 'config'
        #pp build.get_factory 'config'
      end

    end
  end
end