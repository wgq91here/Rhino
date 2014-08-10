module Rhino
  module Db
	attr_accessor :db, :dns

	def getDb
	  @db = Sequel.connect(@dns) if @db == nil
	  @db
	end

	def create!
	  logger(:info, 'Create Db!')
	  @db = Sequel.connect(@dns)
	  @db.create_table :project do
		primary_key :id
		String :name
		String :path
		String :author
	  end
	end

	private 
	def logger(level, message)
	  lg = Rhino.logger.method level.to_sym
	  lg.call (self.class.to_s + ' ').colorize(:light_blue) + message.to_s
	end
  end
end
