require 'pry'
class Pokemon

  attr_reader :id, :name, :type, :db, :hp
  @@all = []

  def initialize(id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp.nil? ? 60 : hp

    @@all << self
  end

  def self.save(pokemon_name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", pokemon_name, type)
  end

  def self.find(id, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE pokemon.id = (?)", id)
    id, name, type, hp = pokemon.flatten
    
    Pokemon.new(id: id, name: name, type: type, hp: hp, db: db)
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = (?) WHERE pokemon.id = (?)", hp, self.id)
  end


end
