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

	def initialize(cells, fState, type)
		@cellsPos = []
		cells.each{ |cell|
			@cellsPos.push({"x"=>cell.row,"y"=>cell.col})
		}
		@firstState = fState
		@type = type
	end

	def replay(game)
		@cellsPos.each{ |cell|
			if @type == :primary
				game.cellAt(cell["x"],cell["y"]).primaryChange
			else
				game.cellAt(cell["x"],cell["y"]).secondaryChange
			end
		}
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
