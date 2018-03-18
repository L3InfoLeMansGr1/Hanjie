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

	def replay(gridUi)
		if @type == :primary
			gridUi.cellAt(@cellPos["x"],@cellPos["y"]).primaryChange
		else
			gridUi.cellAt(@cellPos["x"],@cellPos["y"]).secondaryChange
		end
	end
end

class GuessMove < Move
	@type         # :begin :remove :apply

	def initialize(type)
		@type = type
	end

	def replay(gridUi)
		if @type == :begin
			gridUi.beginGuess
		elsif @type == :remove
			gridUi.removeGuess
		else
			gridUi.applyGuess
		end
	end
end
