module Ma   
  MA_VALUE = 1  
  def ma_1   
    puts "it is ma_1"  
  end   
end   
  
module Mb   
  MB_VALUE = 1  
  def self.included(c)   
    def c.mb_2   
      puts "it is mb_2"  
    end   
  end   
  def mb_1   
    puts "it is mb_1"  
  end   
end   
  
class Ca   
  include Ma      
end   
     
class Cb   
  extend Ma   
  include Mb   
end   
  
c1 = Ca.new  
c1.ma_1   
  
c2 = Cb.new  
c2.mb_1   
Cb.ma_1   
Cb.mb_2   
  
puts Ma::MA_VALUE   
puts Ca::MA_VALUE   
  
puts Mb::MB_VALUE   
puts Cb::MB_VALUE  