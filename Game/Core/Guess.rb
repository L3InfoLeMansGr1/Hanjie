require File.dirname(__FILE__) + "/Moves"


##
# Representation of a Guess, a Guess is like a removable try
class Guess
	@prev
	@grid
	@moves

	attr_accessor :prev #The previous Guess
	attr_accessor :moves #The Moves of the Guess
	attr_reader :grid #The Grid

	##
	# Creates a new Guess object
	# * *Arguments* :
	#   - +grid+     -> the Grid
	#   - +prev+     -> the previous Guess if there is one
	def initialize(grid, prev = nil)
		@prev = prev
		@grid = grid
		@moves = Moves.new()
	end

	##
	# Returns a boolean indicates if this Guess is the root one (i.e there no previous guess)
	# * *Returns* :
	#   - Boolean
	def root?
		@prev == nil
	end

	##
	# Returns a new Guess who has this one as previous
	# * *Returns* :
	#   - Guess
	def next
		Guess.new(@grid.copyFrozen, self)
	end

	##
	# Returns the Cell at the given row, col
	# * *Arguments* :
	#   - +row+     -> The row index of The wanted Cell
	#   - +col+     -> The col index of The wanted Cell
	# * *Returns* :
	#   - The Cell
	def cellAt(row, col)
		@grid.cellAt(row, col)
	end

	def getSolverCellRow(rowi)
		@grid.getSolverCellRow(rowi)
	end

	def getSolverCellCol(coli)
		@grid.getSolverCellCol(coli)
	end

	def to_s
		@grid.to_s
	end

	##
	# Undo the last Move did in this Guess
	# * *Arguments* :
	#   - +game+     -> The game
	def undo(game)
		@moves.undo(game)
	end

	##
	# Redo the last Move did in this Guess
	# * *Arguments* :
	#   - +game+     -> The game
	def redo(game)
		@moves.redo(game)
	end

end
