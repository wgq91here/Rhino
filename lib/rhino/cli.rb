require 'rhino'
require 'thor'
require 'pp'

module Rhino
  class Cli < Thor
    include Thor::Actions
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


    # 自我的初始化
    desc 'init', 'Init Rhino config.'
    long_desc <<-LONGDESC
    RHINO 初始化命令 \n
    1. 建立 rhino.config \n
    2. 检查数据存储是否有效 \n
    3. 检查数据存储格式是否正确 \n
    4. 列出当前项目个数以及名称 \n

    > $ rhino init

    LONGDESC
    method_option :clean,
                  :type => :string,
                  :default => false,
                  :desc => 'If clean rhino data.'

    def init
      pp options
    end

    # 根据给出YAML 直接 输出 项目
    desc 'project', 'Build project by YAML.'
    long_desc <<-LONGDESC
    直接按照给出的YAML来生成应用程序.

    > $ rhino project --yaml=app

    LONGDESC
    map '-p' => :project
    method_option :yaml,
                  :type => :string,
                  :required => true,
                  :default => :app,
                  :desc => 'Build project by Yaml file.'

    def project
      say '=>'+' ' *6 + Rhino.version
      require 'rhino/project'
      Rhino::Project.app_name = options['yaml']
      Rhino::Project.components = {}
      #puts Rhino::Project.project_yaml_file
      #puts Rhino::Project.get_yaml
      #pp Rhino::Project.register(:config, Rhino::Project::Config.new)
      pp Rhino::Project.app_name
      pp Rhino::Project.components
      pp Rhino::Project.instance_variables

      #puts Rhino::Project::Config.new

      #require File.expand_path('../build/init', __FILE__)
      #build = Rhino::Build::Init.new options
      #require 'pp'
      #pp build.getStruct
      #build.register('config')
      #pp build.get_factory 'config'
      #pp build.get_factory 'config'
    end

    # 重新调用 YAML 根据其中内容 生成项目文件
    # 将询问是否覆盖
    desc 'reload', 'Reload changed yaml and change exist project.'
    long_desc <<-LONGDESC
    ReWrite some code by changed Yaml.
    LONGDESC

    map '-reload' => :reload
    method_option :yaml,
                  :type => :string,
                  :required => true,
                  :default => :app,
                  :desc => 'Build project by Yaml file.'
    method_option :force,
                  :type => :boolean,
                  :default => false,
                  :aliases => '-f',
                  :desc => 'force change code by yaml file.'

    def reload
      say '=>'+' ' *6 + Rhino.version
      require 'rhino/project'
      Rhino::Project.app_name = options['yaml']
      say 'Reload'
    end

    # 显示 项目 组件信息
    desc 'list', 'List project component\'s info.'
    map '-l' => :list
    method_option :component,
                  :type => :array,
                  :default => %w(config db auth data event theme),
                  :desc => 'Given component\'s names.'

    def list
      pp options
    end

    # 输出 项目 YAML
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
      run(destination_root + '/bin/rhino component test' + ' --app ' + options['app'] + ' --env=' + options['env'])
    end

    # 项目组件的 命令方式定义 一般由程序来执行此部分
    desc 'component', 'Rhino component actions.'
    #subcommand 'component', Component
    register(Rhino::Component, 'component', 'component', 'Prints some numbers in sequence')


    desc 'version', 'Show Rhino version.'

    def version
      say 'Rhino version: ' + Rhino.version
    end

  end
end
