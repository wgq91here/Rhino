module Delegator #:nodoc:
    def self.delegate(*methods)
      methods.each do |method_name|
        define_method(method_name) do |*args, &block|
          return super(*args, &block) if respond_to? method_name
          Delegator.target.send(method_name, *args, &block)
        end
        private method_name
      end
    end

    delegate :get, :patch, :put, :post, :delete, :head, :options, :link, :unlink,
             :template, :layout, :before, :after, :error, :not_found, :configure,
             :set, :mime_type, :enable, :disable, :use, :development?, :test?,
             :production?, :helpers, :settings, :register

    class << self
      attr_accessor :target
    end  


	  class Application

	    def self.register(*extensions, &block) #:nodoc:
	      added_methods = extensions.map {|m| m.public_instance_methods }.flatten
	      Delegator.delegate(*added_methods)
	      super(*extensions, &block)
	    end
	  end
self.target = Application

	def get(path, opts = {}, &block)
        puts block.call
      end
  end

  extend Delegator

get('/') { 'this is a simple app' }