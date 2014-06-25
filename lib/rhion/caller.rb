module Rhion

  # List of callers in a Rhion application that should be ignored as part of a stack trace.
  RHION_IGNORE_CALLERS = [
    %r{lib/Rhion-.*$},
    %r{/Rhion-.*/(lib|bin)},
    %r{/bin/Rhion$},
    %r{/sinatra(/(base|main|show_?exceptions))?\.rb$},
    %r{lib/tilt.*\.rb$},
    %r{lib/rack.*\.rb$},
    %r{lib/mongrel.*\.rb$},
    %r{lib/shotgun.*\.rb$},
    %r{bin/shotgun$},
    %r{\(.*\)},
    %r{shoulda/context\.rb$},
    %r{pry},
    %r{mocha/integration},
    %r{test/unit},
    %r{rake_test_loader\.rb},
    %r{custom_require\.rb$},
    %r{active_support},
    %r{/thor}
  ] unless defined?(RHION_IGNORE_CALLERS)

  ##
  # Add rubinius (and hopefully other VM implementations) ignore patterns ...
  #
  RHION_IGNORE_CALLERS.concat(RUBY_IGNORE_CALLERS) if defined?(RUBY_IGNORE_CALLERS)

  private
  ##
  # The filename for the file that is the direct caller (first caller).
  #
  # @return [String]
  #   The file the caller method exists in.
  #
  def self.first_caller
    caller_files.first
  end

  #
  # Like +Kernel#caller+ but excluding certain magic entries and without
  # line / method information; the resulting array contains filenames only.
  #
  # @return [Array<String>]
  #   The files of the calling methods.
  #
  def self.caller_files
    caller(1).
      map    { |line| line.split(/:(?=\d|in )/)[0,2] }.
      reject { |file,line| RHION_IGNORE_CALLERS.any? { |pattern| file =~ pattern } }.
      map    { |file,line| file }
  end
end
