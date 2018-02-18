require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"

class Game
	@currentGuess
	@rowClues
	@colClues
	@nCol
	@nRow

	attr_reader :rowClues, :colClues, :nRow, :nCol

	def initialize(rowClues, colClues)
		@rowClues = rowClues
		@colClues = colClues
		@nCol = colClues.size
		@nRow = rowClues.size
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol	))
	end


	def beginGuess
		@currentGuess = @currentGuess.next()
	end

	def removeGuess
		@currentGuess = @currentGuess.prev()
	end

	def applyGuess
		@currentGuess.apply
		removeGuess()
	end

	def cellAt(row, col)
		@currentGuess.cellAt(row, col)
	end
end
