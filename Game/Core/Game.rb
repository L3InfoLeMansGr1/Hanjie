require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"

class Game
	@currentGuess
	@rowClues
	@colClues
	@nCol
	@nRow
	@save

	attr_reader :rowClues, :colClues, :nRow, :nCol, :save

	def initialize(rowClues, colClues, save)
		@rowClues = rowClues
		@colClues = colClues
		@nCol = colClues.size
		@nRow = rowClues.size
		@currentGuess = Guess.new(Grid.new(@nRow, @nCol))
		@save = save
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

	def rowSolved?(rowi)
		getSolverRow(rowi).solved?
	end

	def colSolved?(coli)
		getSolverCol(coli).solved?
	end

	def solved?
		colSolved = (0...@nCol).all? {|i|
			getSolverCol(i).solved?
		}

		rowSolved = (0...@nRow).all? {|i|
			rowSolved?(i)
		}

		return colSolved && rowSolved
	end
end
