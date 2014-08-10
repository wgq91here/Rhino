module Test1
  def test1
    'Test1.test1'
  end
end

module Test2
  def test2
    #puts '------------> ' + test2_in_class
    'Test2.test2'
  end
  def Test2.testall
    #puts '------------> ' + test2_in_class
    'Test2.testall'
  end

  module ClassMethods
    def use_fiber_pool
    	include UsesFiberPool	    
      'use_fiber_pool'            
    end
  end

  module UsesFiberPool
    def callback_wrapper
      'callback_wrapper'
    end  	
  end

  class << self
    attr_accessor :target
    def test2_in_class
      # load module def
      #puts '=>>>>>>>>>' + Test2.test2

      'Test2.test2_in_class'
    end
    include ClassMethods

    puts 'im UsesFiberPool'
  end
end

class Test
  include Test1
  include Test2

  def run
    test
    test1
  end

  def test
    puts Test2.testall
    puts Test2.target
    puts 'Test2.target!?' if Test2.target != nil
    Test2.target = 'Test2.target'
    puts Test2.target if Test2.target != nil
    puts Test2.test2_in_class
    puts test1
  end

  def test1
    Test2.target = 'Test2.target change in test1'
  end
end

class Test_2
  include Test2

  def run
    test
  end

  def test
    puts Test2.target
  end
end

t = Test.new
t.run
puts Test2.testall

t2 = Test_2.new
t2.run
puts ':->'
puts Test2.use_fiber_pool
puts ':->'
puts t2.dup
#
#puts Test2.methods

puts Test2::test2_in_class
