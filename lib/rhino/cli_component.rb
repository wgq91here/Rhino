# encoding: utf-8

require 'rhino'
require 'thor'
require 'pp'

module Rhino
  module CLI
    class Component < Cli
      include Thor::Actions
      # config auth data event theme
      class_option :env,
                   :type => :string,
                   :enum => %w(development product test),
                   :aliases => '-e',
                   :desc => 'Rhino Environment.'
      class_option :app,
                   :type => :string,
                   :aliases => '-a',
                   :required => true,
                   :desc => 'Project app name.'

      desc 'config', 'Rhino Config component.'
      method_option :yaml,
                    :aliases => '-y',
                    :type => :string,
                    :default => '',
                    :desc => 'Given config yaml.'

      def config
        pp options
      end

      desc 'auth', 'Rhino Auth component.'

      def auth
        say 'Rhino version: ' + Rhino.version
        pp options
      end

      desc 'data', 'Rhino Data component.'

      def data
        say 'Rhino version: ' + Rhino.version
        pp options
      end

      desc 'event', 'Rhino Event component.'

      def event
        say 'Rhino version: ' + Rhino.version
        pp options
      end

      desc 'theme', 'Rhino Theme component.'

      def theme
        say 'Rhino version: ' + Rhino.version
        pp options
      end
    end
  end
end