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
	@cellsPos     # position of each
	@firstState   # the state of the first cell
	@type         # :primary :secondary

	def initialize

	end
end
