require 'rhino'
require 'thor'
require 'pp'

module Rhino
  class Component < Thor
    include Thor::Actions

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

    desc 'test', 'Test Rhino components.'
    def test
      say 'Rhino version: ' + Rhino.version
      pp options
    end

    desc 'test1', 'Test Rhino components.'
    def test1
      say 'Rhino version: ' + Rhino.version
      pp options
    end

  end

end