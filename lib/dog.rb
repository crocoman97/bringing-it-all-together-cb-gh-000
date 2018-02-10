class Dog 
  
  attr_accessor :name,:breed 
  attr_reader :id
  
  def initialize(name:,breed:,id: nil)
    @name, @breed,@id = name, breed,id
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE dogs IF NOT EXITS (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)
    SQL
    DB[:conn].execute(sql)
  end
  
end




# learn --fail-fast


