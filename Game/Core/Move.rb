##
# A move is an action from the user who change the state of the current game
# Logging them allow the user to retrieve a game where it was

class Move
	@timeStamp

	def initialize(timeStamp)
		@timeStamp = timeStamp

	end

	def serialize

	end
end

class CellMove < Move
	@cellPos     # position of cell
	#@firstState   # the state of the first cell
	@type         # :primary :secondary

	def initialize(x,y,type)
		@cellPos= {"x"=>x,"y"=>y}
		@type = type
	end

	def replay(game)
		if @type == :primary
			game.cellAt(@cellPos["x"],@cellPos["y"]).primaryChange
		else
			game.cellAt(@cellPos["x"],@cellPos["y"]).secondaryChange
		end
	end
end

class GuessMove < Move
	@type         # :begin :remove :apply

	def initialize(type)
		@type = type
	end

	def replay(game)
		if @type == :begin
			game.beginGuess
		elsif @type == :remove
			game.removeGuess
		else
			game.applyGuess
		end
	end
end
