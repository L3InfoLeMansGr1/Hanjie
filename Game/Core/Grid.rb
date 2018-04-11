require File.dirname(__FILE__) + "/Cell"

##
# Representation of a Grid
class Grid
	@rows #All Cell s ordered by line
	@cols #All Cell s ordered by Column

	attr_reader :rows #All Cell s ordered by line
	attr_reader :cols #All Cell s ordered by Column

	##
	# Creates a new Grid object
	# * *Arguments* :
	#   - +nRow+     -> the number of rows
	#   - +nCol+     -> the number of columns
	def initialize(nRow, nCol)
		@rows = (1..nRow).map {
			(1..nCol).map { Cell.new }
		}

		@cols = @rows.transpose
	end

	##
	# Returns the a frozen copy of this Grid
	# * *Returns* :
	#   - a copy of this Grid
	def copyFrozen
		newG = Grid.new(@rows.size, @cols.size)
		@rows.zip(newG.rows).each {|oldRow, newRow|
			oldRow.zip(newRow).each { |oldCell, newCell|
				newCell.frozenOf(oldCell)
			}
		}
		return newG
	end

	##
	# Returns the Cell at the given row, col
	# * *Arguments* :
	#   - +row+     -> The row index of The wanted Cell
	#   - +col+     -> The col index of The wanted Cell
	# * *Returns* :
	#   - The Cell
	def cellAt(row, col)
		return @rows[row][col]
	end

	def getSolverCellRow(rowi)
		@rows[rowi].map(&:to_solverCell)
	end

	def getSolverCellCol(coli)
		@cols[coli].map(&:to_solverCell)
	end

	def to_s
		@rows.map{ |row|
			row.map(&:to_s).join
		}.join("\n")
	end

end
