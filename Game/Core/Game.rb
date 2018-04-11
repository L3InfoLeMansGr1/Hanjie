require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/Chronometre"

##
# Representation of a Game
class Game
	@currentGuess #The current Guess
	@rowClues #Row Clues
	@colClues #Col Clues
	@nCol #Number of columns
	@nRow #Number of rows
	@save #The Save
	@timer #The Chronometre
	@winObs #A List of win observer

	attr_accessor :currentGuess #The current Guess
	attr_reader :rowClues #Row Clues
	attr_reader :colClues #Col Clues
	attr_reader :nRow #Number of columns
	attr_reader :nCol #Number of rows
	attr_reader :save #The Save
	attr_reader :timer #The Chronometre

	##
	# Creates a new Game object
	# * *Arguments* :
	#   - +rowClues+     -> Row Clues
	#   - +colClues+     -> Col Clues
	#   - +save+     -> The save to write in
	#   - +timer+     -> The Chronometre
	def initialize(rowClues, colClues, save, timer)
		@rowClues = rowClues
		@colClues = colClues
		@nCol = colClues.size
		@nRow = rowClues.size
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol))
		@save = save
		@timer = timer
		@winObs = []
	end

	##
	# Add a win observer
	# * *Arguments* :
	#   - +obs+     -> a Proc to call when the Game is Won
	def addWinObservator(obs)
		@winObs << obs
	end

	##
	# Notify all win observers that the Game was just won
	def notifyWin
		@winObs.each(&:call)
	end

	##
	# Begin a new Guess
	def beginGuess
		@currentGuess = @currentGuess.next()
	end

	##
	# Remove the last Guess done
	def removeGuess
		@currentGuess = @currentGuess.prev()
	end

	##
	# Apply the Guess
	def applyGuess
		@currentGuess.apply
		removeGuess()
	end

	##
	# Returns the Cell at the given row, col
	# * *Arguments* :
	#   - +row+     -> The row index of The wanted Cell
	#   - +col+     -> The col index of The wanted Cell
	# * *Returns* :
	#   - The Cell
	def cellAt(row, col)
		@currentGuess.cellAt(row, col)
	end


	def getGoodBlocksRow(index)
		axe = getSolverRow(index)
		return axe.goodBlocks
	end

	def getGoodBlocksCol(index)
		axe = getSolverCol(index)
		return axe.goodBlocks
	end

	def getSolverRow(rowi)
		row = @currentGuess.getSolverCellRow(rowi)
		axe = Solver::Axe.new(row, @rowClues[rowi])
		return axe
	end

	def getSolverCol(coli)
		col = @currentGuess.getSolverCellCol(coli)
		axe = Solver::Axe.new(col, @colClues[coli])
		return axe
	end

	##
	# Returns a boolean indicate if the row at the given index is solved or not
	# * *Arguments* :
	#   - +rowi+     -> The row index
	# * *Returns* :
	#   - Boolean
	def rowSolved?(rowi)
		getSolverRow(rowi).solved?
	end

	##
	# Returns a boolean indicate if the cel at the given index is solved or not
	# * *Arguments* :
	#   - +coli+     -> The col index
	# * *Returns* :
	#   - Boolean
	def colSolved?(coli)
		getSolverCol(coli).solved?
	end

	##
	# Returns a boolean indicate if the game is won or not. If the game is won, call notifyWin
	# * *Returns* :
	#   - Boolean
	def win?
		if (0...@nRow).all?{|ri| rowSolved?(ri)} && (0...@nCol).all?{|ci| colSolved?(ci)}
			notifyWin
			return true
		end

		return false
	end

	##
	# Returns a boolean indicate if the game is solved
	# * *Returns* :
	#   - Boolean
	def solved?
		colSolved = (0...@nCol).all? {|i|
			getSolverCol(i).solved?
		}

		rowSolved = (0...@nRow).all? {|i|
			rowSolved?(i)
		}

		return colSolved && rowSolved
	end

	def to_s
		@currentGuess.to_s
	end

end
