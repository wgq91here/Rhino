require 'thor'

module Rhino
  module Cli
    class Base < Thor
      include Thor::Actions

      class << self
        require File.expand_path('../../version', __FILE__)
      end

      class_option :chdir, :type => :string, :aliases => '-c', :desc => 'Change to dir before starting.'
      class_option :environment, :type => :string, :aliases => '-e', :required => true, :default => :development, :desc => 'Rhino Environment.'
      class_option :help, :type => :boolean, :desc => 'Show help usage'

      desc 'build', 'Build project by YAML.'
      map '-b' => :build
      method_option :yaml, :type => :string, :required => true, :default => :app, :desc => 'Build by Yaml file.'
      #
      def build
        #prepare :build
        #require File.expand_path('../../../version/version', __FILE__)
        #require File.expand_path("../adapter", __FILE__)

        puts $:.to_s
        require 'build/build'
        say "=> Build Project by YAML (Rhino v.#{Rhino.version})"
        #require Rhino::Generators::Build
        start(options)
        #build!(options)

      end
    end
  end

end