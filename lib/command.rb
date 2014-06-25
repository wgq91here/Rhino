require 'rbconfig'

module Rhino
  ##
  # This method return the correct location of padrino bin or
  # exec it using Kernel#system with the given args.
  #
  # @param [Array] args
  #   command or commands to execute
  #
  # @return [Boolean]
  #
  # @example
  #   Padrino.bin('start', '-e production')
  #
  def self.bin(*args)
    @_rhino_bin ||= [self.ruby_command, File.expand_path("../../bin/rhino", __FILE__)]
    args.empty? ? @_rhino_bin : system(args.unshift(@_rhino_bin).join(" "))
  end

  ##
  # This method return the correct location of padrino-gen bin or
  # exec it using Kernel#system with the given args.
  #
  # @param [Array<String>] args.
  #   Splat of arguments to pass to padrino-gen.
  #
  # @example
  #   Padrino.bin_gen(:app, name.to_s, "-r=#{destination_root}")
  #
  def self.bin_gen(*args)
    @_rhino_gen_bin ||= [Padrino.ruby_command, File.expand_path("../../bin/padrino-gen", __FILE__)]
    system args.unshift(@_rhino_gen_bin).join(" ")
  end

  ##
  # Return the path to the ruby interpreter taking into account multiple
  # installations and windows extensions.
  #
  # @return [String]
  #   path to ruby bin executable
  #
  def self.ruby_command
    @ruby_command ||= begin
      ruby = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])
      ruby << RbConfig::CONFIG['EXEEXT']

      # escape string in case path to ruby executable contain spaces.
      ruby.sub!(/.*\s.*/m, '"\&"')
      ruby
    end
  end
end
