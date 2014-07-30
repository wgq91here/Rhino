module Rhino
  class Init
	attr_accessor :init_file, :init_config

	def initialize
	  @init_file = RHINO_ROOT + '/rhino.yaml'
	  @init_config = { rhino_version: Rhino.version }
	  #setup
	end

	def setup
	  logger(:info, 'Rhino config file is ' + @init_file.colorize(:green))
	  if !configExist?
		logger(:error, 'Config not exist!')
		logger(:info, 'Create New config file.')
		initConfig
	  else
		logger(:info, 'Found Config!')
		@init_config = load
		logger(:info, @init_config)
	  end
	  save
	  #setDb @init_config['dns']
	  #db = Db.getDb
	  logger(:info, 'getDB')
	  #project = db[:project]
	  #logger(:info, project.all)
	  logger(:info, 'Save Config.')
	end

	def initConfig
	  @init_config = {
		rhino_version: Rhino.version,
		dns: 'sqlite://' + RHINO_ROOT + '/rhino.db'
	  }
	end

	def setConfig(key, value)
	  @init_config[key.to_sym] = value
	end

	def configExist?
	  File.exist?(@init_file)
	end

	def load
	  YAML.load(File.open(@init_file, 'r'))
	end

	def save
	  File.open(@init_file, 'w+') { |f| f.write(@init_config.to_yaml) }
	end

	private
	def logger(level, message)
	  lg = Rhino.logger.method level.to_sym
	  lg.call (self.class.to_s + ' ').colorize(:light_blue) + message.to_s
	end
  end
end
