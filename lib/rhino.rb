require 'rhino/version'
require 'rhino/cli'
require 'rhino/cli_component'
require 'rhino/util'
require 'rhino/logger'
require 'rhino/db'
require 'colorize'
require 'sequel'

module Rhino
  #extend Rhino::Util
  #autoload :Project, 'rhino/project'
  class << self

    def set(option, value = (not_set = true), ignore_setter = false, &block)
      raise ArgumentError if block and !not_set
      value, not_set = block, false if block

      if not_set
        raise ArgumentError unless option.respond_to?(:each)
        option.each { |k,v| set(k, v) }
        return self
      end

      if respond_to?("#{option}=") and not ignore_setter
        return __send__("#{option}=", value)
      end

      setter = proc { |val| set option, val, true }
      getter = proc { value }

      case value
        when Proc
          getter = value
        when Symbol, Fixnum, FalseClass, TrueClass, NilClass
          getter = value.inspect
        when Hash
          setter = proc do |val|
            val = value.merge val if Hash === val
            set option, val, true
          end
      end

      define_singleton("#{option}=", setter) if setter
      define_singleton(option, getter) if getter
      define_singleton("#{option}?", "!!#{option}") unless method_defined? "#{option}?"
      self
    end

    ##
    # Helper method for file references.
    #
    # @param [Array<String>] args
    #   The directories to join to {RHINO_ROOT}.
    #
    # @return [String]
    #   The absolute path.
    #
    # @example
    #   # Referencing a file in config called settings.yml
    #   Rhino.root("config", "settings.yml")
    #   # returns RHINO_ROOT + "/config/setting.yml"
    #
    def root(*args)
      File.expand_path(File.join(RHINO_ROOT, *args))
    end

    ##
    # Helper method that return {RACK_ENV}.
    #
    # @return [Symbol]
    #   The Rhino Environment.
    #
    def env
      @_env ||= RACK_ENV.to_s.downcase.to_sym
    end

    ##
    # The resulting rack builder mapping each 'mounted' application.
    #
    # @return [Rhino::Router]
    #   The router for the application.
    #
    # @raise [ApplicationLoadError]
    #   No applications were mounted.
    #
    def application
      warn 'WARNING! No apps are mounted. Please, mount apps in `config/apps.rb`' unless Rhino.mounted_apps.present?
      router = Rhino::Router.new
      Rhino.mounted_apps.each { |app| app.map_onto(router) }
      middleware.present? ? add_middleware(router) : router
    end

    ##
    # Configure Global Project Settings for mounted apps. These can be overloaded
    # in each individual app's own personal configuration. This can be used like:
    #
    # @yield []
    #   The given block will be called to configure each application.
    #
    # @example
    #   Rhino.configure_apps do
    #     enable  :sessions
    #     disable :raise_errors
    #   end
    #
    def configure_apps(&block)
      return unless block_given?
      global_configurations << block
    end

    ##
    # Stores global configuration blocks.
    #
    def global_configurations
      @_global_configurations ||= []
    end

    ##
    # Set +Encoding.default_internal+ and +Encoding.default_external+
    # to +Encoding::UFT_8+.
    #
    # Please note that in +1.9.2+ with some template engines like +haml+
    # you should turn off Encoding.default_internal to prevent problems.
    #
    # @see https://github.com/rtomayko/tilt/issues/75
    #
    # @return [NilClass]
    #
    def set_encoding
      Encoding.default_external = Encoding::UTF_8
      Encoding.default_internal = Encoding::UTF_8
      nil
    end

    ##
    # Creates Rack stack with the router added to the middleware chain.
    #
    def add_middleware(router)
      builder = Rack::Builder.new
      middleware.each { |mw, args, block| builder.use(mw, *args, &block) }
      builder.run(router)
      builder.to_app
    end

    ##
    # A Rack::Builder object that allows to add middlewares in front of all
    # Rhino applications.
    #
    # @return [Array<Array<Class, Array, Proc>>]
    #   The middleware classes.
    #
    def middleware
      @middleware ||= []
    end

    ##
    # Clears all previously configured middlewares.
    #
    # @return [Array]
    #   An empty array
    #
    def clear_middleware!
      @middleware = []
    end

    ##
    # Convenience method for adding a Middleware to the whole Rhino app.
    #
    # @param [Class] m
    #   The middleware class.
    #
    # @param [Array] args
    #   The arguments for the middleware.
    #
    # @yield []
    #   The given block will be passed to the initialized middleware.
    #
    def use(mw, *args, &block)
      middleware << [mw, args, block]
    end

    ##
    # Registers a gem with Rhino. This relieves the caller from setting up
    # loadpaths by itself and enables Rhino to look up apps in gem folder.
    #
    # The name given has to be the proper gem name as given in the gemspec.
    #
    # @param [String] name
    #   The name of the gem being registered.
    #
    # @param [Module] main_module
    #   The main module of the gem.
    #
    # @returns The root path of the loaded gem
    def gem(name, main_module)
      _, spec = Gem.loaded_specs.find { |spec_pair| spec_pair[0] == name }
      gems << spec
      modules << main_module
      spec.full_gem_path
    end

    ##
    # @returns [Gem::Specification]
    def gems
      @gems ||= []
    end

    ##
    # @returns [<Rhino::Module>]
    def modules
      @modules ||= []
    end
  end
end
