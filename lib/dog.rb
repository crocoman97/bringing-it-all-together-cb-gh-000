class Dog 
  
  attr_accessor :name,:breed 
  
  def initialize(name:,breed:)
    @name, @breed = name, breed
  end
  
  
end


# learn --fail-fast