class Save

	@mode
	@moves
	@path
	@rows
	@cols
	attr_reader :rows, :cols

	def initialize(path="",rows = nil, cols= nil, mode = "", level="")
		if path != ""
			path = "./Saves/"+path
			@path = Pathname.new(path)
			data = YAML.load_file(path)
		else
			@path = Pathname.new("./Saves/"+mode+"&"+level+"&"+Time.now.to_s+".yaml")
			data = {"rows"=>rows, "cols"=>cols , "moves"=>Moves.new }
			File.open(@path, "w") {|out| out.puts data.to_yaml }
		end
		@rows = data["rows"]
		@cols = data["cols"]
		@moves = data["moves"]
	end


	def write()
		data = {"rows"=>@rows, "cols"=>@cols , "moves"=>@moves }
		File.open(@path, "w") {|out| out.puts data.to_yaml }
	end

	def add(move)
		@moves.add(move)
		write
	end

	def load(game)
		@moves.replay(game)
	end

end
