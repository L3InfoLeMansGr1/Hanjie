require File.dirname(__FILE__) + "/Blocks"

module Solver
class Axe
	@blocks


	def initialize(cells, clues=[])
		@blocks = Blocks.new(cells, clues)
		@cells = cells
		@clues = clues
	end

	# return the indexes of new information
	def solve
		# p @clues
		# p @cells.map(&:to_s).each_slice(5).map(&:join).join(" ")
		return [-1] unless @blocks.compact
		# puts @blocks if @clues == [5, 1, 1, 3, 13]

		blackCellsInIntersection = @blocks.intersections
		whiteCellsInGap = @blocks.gaps

		blackCellsByMinMaxPossibleSize = @blocks.minMaxPossibleSize
		whiteCellsByFillingLittleGaps = @blocks.littleGapsInRange

		newInfo = blackCellsInIntersection + blackCellsByMinMaxPossibleSize + whiteCellsInGap + whiteCellsByFillingLittleGaps

		# p @cells.map(&:to_s).each_slice(5).map(&:join).join(" ")
		return newInfo

	end

	# are all the black cells forming a valid solution ?
	def solved?
		return @blocks.clues == showingClues
	end

	def showingClues
		@blocks.getBlocksRanges{|cell| cell.state == :black}.map { |first, last|
			last-first+1
		}
	end
end # class Axe
end # module Solver
