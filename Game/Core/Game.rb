require File.dirname(__FILE__) + "/Guess"
require File.dirname(__FILE__) + "/Grid"
require File.dirname(__FILE__) + "/Chronometre"

class Game
	@currentGuess
	@rowClues
	@colClues
	@nCol
	@nRow
	@save
	@timer
	@winObs

	attr_accessor :currentGuess
	attr_reader :rowClues, :colClues, :nRow, :nCol, :save, :timer

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

	def addWinObservator(obs)
		@winObs << obs
	end

	def notifyWin
		@winObs.each(&:call)
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

	def win?
		if (0...@nRow).all?{|ri| rowSolved?(ri)} && (0...@nCol).all?{|ci| colSolved?(ci)}
			notifyWin
			return true
		end

		return false
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

	def to_s
		@currentGuess.to_s
	end

end
