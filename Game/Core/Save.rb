require 'pathname'
require 'yaml'


class Save

	@mode
	@moves
	@path
	@rows
	@cols
	@time
	@level
	attr_reader :rows, :cols, :mode, :time, :level, :nbGames

	def initialize(path="",rows = nil, cols= nil, mode = "", level="", time = 0)
		if path != ""
			@level = path.split("&")[1]
			@mode = path.split("&")[0]
			path = File.dirname(__FILE__) + "/Saves/"+path
			@path = Pathname.new(path)
			data = YAML.load_file(path)
		else
			date = Time.now
			@level = level
			@path = Pathname.new(File.dirname(__FILE__) + "/Saves/"+mode+"&"+level+"&"+date.to_s.split(' ').join('_')+".yml")
			data = {"rows"=>rows, "cols"=>cols , "moves"=>Moves.new , "time"=>time, "nbGames" => 0}
			File.open(@path.to_s, "w") {|out| out.puts data.to_yaml }
		end
		@rows = data["rows"]
		@cols = data["cols"]
		@moves = data["moves"]
		@time = data["time"]
		@nbGames = data["nbGames"]
	end


	def write()
		data = {"rows"=>@rows, "cols"=>@cols , "moves"=>@moves , "time"=> @time, "nbGames" => @nbGames}
		File.open(@path, "w") {|out| out.puts data.to_yaml }
		# p @time # damn
	end

	def add(move,game)
		@moves.add(move)
		move.replay(game)
		@time = game.timer.sec
		write
	end

	def load(game)
		@moves.replay(game)
	end

	def delete
		File.delete(@path)
	end

	def setNbGrids(nbGrids)
		@nbGames = nbGrids
	end

end
