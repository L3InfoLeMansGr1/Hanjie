##
# A Move is an action from the user who change the state of the current game
# Logging them allow the user to retrieve a game where it was

class Move
	@timeStamp

	def initialize(timeStamp)
		@timeStamp = timeStamp

	end

	def serialize

	end
end


##
# A CellMove is an action from the user who changes the state ef one or more Cell
class CellMove < Move
	@cellsPos     # position of each
	@firstState   # the state of the first cell
	@type         # :primary :secondary

	attr_reader :cellsPos #Postion of each Cell
	attr_reader :firstState #State of the first Cell
	attr_reader :type #Type of click (left or right)

	##
	# Creates a new CellMove object
	# * *Arguments* :
	#   - +cells+ -> all modified cells
	#   - +fState+ -> first cell state (:black, :white, :cross)
	#   - +type+ -> type of change (:primary, :secondary)
	def initialize(cells, fState, type)
		@cellsPos = []
		cells.each{ |cell|
			@cellsPos.push({"x"=>cell.row,"y"=>cell.col})
		}
		@firstState = fState
		@type = type
	end

	##
	# Replay this CellMove on the given game and add it to undo stack
	# * *Arguments* :
	#   - +game+ -> The Game to play on
	def replay(game)
		game.currentGuess.moves.add self
		@cellsPos.each{ |cell|
			if @type == :primary
				game.cellAt(cell["x"],cell["y"]).primaryChange
			else
				game.cellAt(cell["x"],cell["y"]).secondaryChange
			end
		}
	end

	##
	# Replay this CellMove on the given game
	# * *Arguments* :
	#   - +game+ -> The Game to play on
	def replayWithoutAdd(game)
		@cellsPos.each{ |cell|
			if @type == :primary
				game.cellAt(cell["x"],cell["y"]).primaryChange
			else
				game.cellAt(cell["x"],cell["y"]).secondaryChange
			end
		}
	end

end


##
# A GuessMove is an action from the user who creates or delete a guess
class GuessMove < Move
	@type         # :begin :remove :apply

	##
	# Creates a new GuessMove object
	# * *Arguments* :
	#   - +type+ -> the type of Guess change (:begin, :remove)
	def initialize(type)
		@type = type
	end

	##
	# Replay this GuessMove on the given game
	# * *Arguments* :
	#   - +game+ -> The Game to play on
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
