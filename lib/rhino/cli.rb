require 'rhino'
require 'thor'
require 'pp'
require 'rhino/init'

module Rhino
  module CLI
    class Cli < Thor
      include Thor::Actions
      require 'rhino/cli_project'
      require 'rhino/cli_component'
      class_option :root,
                   :type => :string,
                   :aliases => '-r',
                   :default => 'apps',
                   :desc => 'Default generate to Apps path.'
      class_option :env,
                   :type => :string,
                   :enum => %w(development product test),
                   :aliases => '-e',
                   :required => true,
                   :default => :development,
                   :desc => 'Rhino Environment.'
      class_option :help,
                   :type => :boolean,
                   :desc => 'Show help usage'
      class_option :version,
                   :desc => 'Show version'

      #
      #
      # init self
      desc 'init', 'Init Rhino config.'
      long_desc <<-LONGDESC
    RHINO Init: \n
    1. create rhino.config \n
    2. check rhino data is valid \n
    3. check rhino data is wrote \n
    4. list rhino project's num and name \n

    > $ rhino init

      LONGDESC
      method_option :clean,
                    :type => :string,
                    :default => false,
                    :desc => 'If clean rhino data.'

      def init
        printVersion
        printAction '[init]'
        Rhino.logger.info('Rhino init...')
		r_init = Rhino::Init.new
		r_init.setup
		r_db = Rhino::Db.new
		r_db.dns = r_init.init_config[:dns] 
		r_db.create!
		pp r_db
      end

      #
      #
      #
      desc 'list', 'List projects info.'
      map '-l' => :list
      method_option :component,
                    :type => :array,
                    :desc => 'Given projects names.'

      def list
        pp options
      end

      #subcommand 'component', Component
      register(Rhino::CLI::Component, 'component', 'component', 'Rhino component actions.')
      register(Rhino::CLI::Project, 'project', 'project', 'Project import & export & reload etc.')

      desc 'version', 'Show Rhino version.'

      def version
        say 'Rhino version: ' + Rhino.version
      end

      private
      def printVersion
        Rhino.logger.info('RHINO version ' + Rhino.version)
      end

      def printAction(action)
        Rhino.logger.info('RHINO Action ' + action.to_s.colorize(:green))
      end
    end
  end
end
