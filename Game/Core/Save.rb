require 'pathname'
require 'yaml'
##
# Representation of a game save

class Save

	@mode #Game mode (one in ["Ranked", "TimeTrial"])
	@moves #Moves done along the game
	@path #Path to save file
	@rows #Row clues
	@cols #Col clues
	@time #Last move date
	@level #Grid level (one in [:easy, :intermediate, :hard])
	@nbGames #The number of won games


	attr_reader :rows  #Row Clues
	attr_reader :cols  #Col Clues
	attr_reader :mode  #Game mode (one in ["Ranked", "TimeTrial"])
	attr_reader :time  #Last Move date
	attr_reader :level #Grid level (one in [:easy, :intermediate, :hard])
	attr_reader :nbGames #The number of won games


	##
	# Creates a new Save object
	# * *Arguments* :
	#   - +path+ -> The path to this Save file
	#   - +rows+ -> Grid row Clues
	#   - +cols+ -> Grid col Clues
	#   - +mode+ -> Game mode (one in ["Ranked", "TimeTrial"])
	#   - +level+ -> Grid level (one in [:easy, :intermediate, :hard])
	#   - +time+ -> Last Move date
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

	##
	# Writes all new informations in this Save file
	def write()
		data = {"rows"=>@rows, "cols"=>@cols , "moves"=>@moves , "time"=> @time, "nbGames" => @nbGames}
		File.open(@path, "w") {|out| out.puts data.to_yaml }
		return self
	end

	##
	# Adds a Move to this Save and play it on a Game
	# * *Arguments* :
	#   - +move+ -> The Move to play
	#   - +game+ -> The Game to play on
	def add(move,game)
		@moves.add(move)
		move.replay(game)
		@time = game.timer.sec
		write
		return self
	end

	##
	# Plays all Moves on a Game
	# * *Arguments* :
	#   - +game+ -> The Game to play on
	def load(game)
		@moves.replay(game)
		return self
	end


	##
	# Deletes this Save
	def delete
		File.delete(@path)
	end

	##
	# Sets the number of won grids
	# * *Arguments* :
	#   - +nbGrids+ -> The number of won grids
	def setNbGrids(nbGrids)
		@nbGames = nbGrids
		return self
	end

	##
	# Clears this Save Moves
	def clear
		@moves = Moves.new
		write
		return self
	end

end
