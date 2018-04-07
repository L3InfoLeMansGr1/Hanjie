require File.dirname(__FILE__) + "/Cell"


class Grid
	@rows
	@cols

	attr_reader :rows, :cols

	def initialize(nRow, nCol)
		@rows = (1..nRow).map {
			(1..nCol).map { Cell.new }
		}

		@cols = @rows.transpose
	end

	def copyFrozen
		newG = Grid.new(@rows.size, @cols.size)
		@rows.zip(newG.rows).each {|oldRow, newRow|
			oldRow.zip(newRow).each { |oldCell, newCell|
				newCell.frozenOf(oldCell)
			}
		}
		return newG
	end

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
