require File.dirname(__FILE__) + "/Blocks"

module Solver
class Axe
	@blocks

	def initialize(cells, clues=[])
		@blocks = Blocks.new(cells, clues)
		@cells = cells
		@clues = clues
	end

	def goodBlocks
		return [-1] unless @blocks.compact
		blocks = (0...@blocks.blocks.length).select {|i| @blocks.blocks[i].known?}
		return blocks
	end

	# return the indexes of new information
	def solve
		# p @clues
		# p @cells.map(&:to_s).each_slice(5).map(&:join).join(" ")
		return [-1] unless @blocks.compact
		# puts @blocks if @clues == [5, 1, 1, 3, 13]

		blackCellsInIntersection = @blocks.intersections
		crossedCellsInGap = @blocks.gaps

		blackCellsByMinMaxPossibleSize = @blocks.minMaxPossibleSize
		crossedCellsByFillingLittleGaps = @blocks.littleGapsInRange

		newInfo = blackCellsInIntersection + blackCellsByMinMaxPossibleSize + crossedCellsInGap + crossedCellsByFillingLittleGaps

		# p @cells.map(&:to_s).each_slice(5).map(&:join).join(" ")
		return newInfo

	end

	def solver_intersections
		# return [-1] unless @blocks.compact
		return @blocks.intersections
	end

	def solver_gaps
		return @blocks.gaps
	end

	def solver_minMaxPossibleSize
		return @blocks.minMaxPossibleSize
	end

	def solver_littleGapsInRange
		return @blocks.littleGapsInRange
	end

	# are all the black cells forming a valid solution ?
	def solved?
		return @blocks.clues == showingClues
	end

	def solvable?
		return @blocks.compact
	end

	def showingClues
		@blocks.getBlocksRanges{|cell| cell.state == :black}.map { |first, last|
			last-first+1
		}
	end

	def to_s
		@blocks.to_s
	end
end # class Axe
end # module Solver


if $0 == __FILE__

	# :cross :black :white
	w, b, c = [:white], [:black], [:cross]
	states = w * 3 + b + w * 4 + b + w
	p states
	clues = [3, 1]
	axe = Solver::Axe.new(
		states.map{|state| Solver::Cell.new(state)},
		clues
	)

	puts axe

	p axe.solve
	puts axe





end
