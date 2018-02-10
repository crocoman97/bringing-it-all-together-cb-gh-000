require 'pry'
class Dog 
  
  attr_accessor :name,:breed 
  attr_reader :id
  
  def initialize(name:,breed:,id: nil)
    @name, @breed,@id = name, breed,id
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE IF EXISTS dogs 
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id 
      self.update
    else 
      sql = <<-SQL
      INSERT INTO dogs (name,breed) VALUES (?,?)
      SQL
      DB[:conn].execute(sql,self.name,self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end
  
  def self.create(name:,breed:)
    dog = Dog.new(name: name,breed: breed)
    dog.save
    dog
  end
  
  def self.find_by_id(id)
    sql = <<-SQL
    SELECT * FROM dogs WHERE id = ?
    SQL
    info = DB[:conn].execute(sql,id).flatten
    Dog.new(name: info[1], breed: info[2], id: info[0])
  end
  
  def self.find_or_create_by(name:,breed:)
    sql = <<-SQL
    SELECT * FROM dogs WHERE name = ? AND breed = ?
    SQL
    dog_info = DB[:conn].execute(sql,name,breed).flatten
    if dog_info.empty?
      create(name: name,breed: breed)
    else 
      Dog.new(name: dog_info[1], breed: dog_info[2], id: dog_info[0])
    end
  end
  
end




# learn --fail-fast


