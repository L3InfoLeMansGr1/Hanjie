require File.dirname(__FILE__) + "/Moves"

class Guess
	@prev
	@grid

	@moves
	attr_accessor :prev,  :moves
	attr_reader :grid

	def initialize(grid, prev = nil)
		@prev = prev
		@grid = grid
		@moves = Moves.new()
	end

	def root?
		@prev == nil
	end

	def next
		Guess.new(@grid.copyFrozen, self)
	end

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

	def undo(game)
		@moves.undo(game)
	end

	def redo(game)
		@moves.redo(game)
	end

end
