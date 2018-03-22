require 'pathname'
require 'yaml'


class Save

	@mode
	@moves
	@path
	@rows
	@cols
	@time
	attr_reader :rows, :cols, :mode, :time

	def initialize(path="",rows = nil, cols= nil, mode = "", level="", time = 0)
		if path != ""
			@mode = path.split("&")[0]
			path = File.dirname(__FILE__) + "/Saves/"+path
			@path = Pathname.new(path)
			data = YAML.load_file(path)
		else
			@path = Pathname.new(File.dirname(__FILE__) + "/Saves/"+mode+"&"+level+"&"+Time.now.to_s.split(' ').join('_')+".yml")
			data = {"rows"=>rows, "cols"=>cols , "moves"=>Moves.new , "time"=>time }
			File.open(@path.to_s, "w") {|out| out.puts data.to_yaml }
		end
		@rows = data["rows"]
		@cols = data["cols"]
		@moves = data["moves"]
		@time = data["time"]
	end


	def write()
		data = {"rows"=>@rows, "cols"=>@cols , "moves"=>@moves , "time"=> @time}
		File.open(@path, "w") {|out| out.puts data.to_yaml }
		p @time
	end

	def add(move,game)
		@moves.add(move)
		move.replay(game)
		puts game.timer.sec
		@time = game.timer.sec
		write
	end

	def load(game)
		@moves.replay(game)
	end

end
