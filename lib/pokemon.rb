class Pokemon
	attr_accessor :id, :name, :type, :hp, :db

	def initialize(params)
		self.id = params[:id]
		self.name = params[:name]
		self.type = params[:type]
		self.hp = params[:hp] if params[:hp]
		self.db = params[:db]
	end

	def self.save(name, type, db)
		db.execute("INSERT INTO pokemon (name, type) VALUES
			(?, ?)", [name, type])
	end

	def self.find(id, db)
		data = db.execute("SELECT * FROM pokemon WHERE id=?", [id])[0]
		params = { id: data[0], name: data[1], type: data[2], hp: data[3], db: db }
		Pokemon.new(params)
	end

	def alter_hp(hp, db)
		self.hp = hp
		db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", [hp, self.id])
	end

end
