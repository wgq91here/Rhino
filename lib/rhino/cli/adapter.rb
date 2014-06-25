require 'thor'

module Rhino
  module Cli
    module Adapter
      class << self
        # Start for the given options a rackup handler
        def start(options)
          Rhino.run!(options.symbolize_keys)
        end

        # Method that stop (if exist) a running Rhino.application
        def stop(options)
          options.symbolize_keys!
          if File.exist?(options[:pid])
            pid = File.read(options[:pid]).to_i
            say "=> Sending INT to process with pid #{pid} wait "
            Process.kill(2, pid) rescue nil
          else
            say "=> #{options[:pid]} not found!"
          end
        end

        # Build project by YAML
        def build(options)
          options.symbolize_keys!
          #include Rhino::Generators::Build
          #Rhino.build!(options)
        end
        end
    end
  end
end
