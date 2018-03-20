require 'pathname'
require 'yaml'


class Save

	@mode
	@moves
	@path
	@rows
	@cols
	attr_reader :rows, :cols, :mode

	def initialize(path="",rows = nil, cols= nil, mode = "", level="")
		if path != ""
			path = File.dirname(__FILE__) + "/Saves/"+path
			@mode = path.split("&")[0]
			@path = Pathname.new(path)
			data = YAML.load_file(path)
		else
			@path = Pathname.new(File.dirname(__FILE__) + "/Saves/"+mode+"&"+level+"&"+Time.now.to_s.split(' ').join('-')+".yml")
			data = {"rows"=>rows, "cols"=>cols , "moves"=>Moves.new }
			File.open(@path.to_s, "w") {|out| out.puts data.to_yaml }
		end
		@rows = data["rows"]
		@cols = data["cols"]
		@moves = data["moves"]
	end


	def write()
		data = {"rows"=>@rows, "cols"=>@cols , "moves"=>@moves }
		File.open(@path, "w") {|out| out.puts data.to_yaml }
	end

	def add(move,game)
		@moves.add(move)
		move.replay(game);
		write
	end

	def load(game)
		@moves.replay(game)
	end

end
