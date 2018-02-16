require File.dirname(__FILE__) + "/Block"
require File.dirname(__FILE__) + "/FirstBlock"
require File.dirname(__FILE__) + "/LastBlock"
require File.dirname(__FILE__) + "/Cell"

module Solver
class Blocks

	@clues
	@cells
	@first
	@last
	@blocks

	attr_reader :clues

	def to_s
		[
			"clues: #{@clues.map(&:to_s).join(' ')}",
			"cells: #{@cells.map(&:to_s).join}",
			"blocks: #{@blocks.map(&:to_s).join}"
		].join("\n")
	end

	def initialize(cells, clues)
		@clues = clues
		@cells = cells
		@first = FirstBlock.new(cells)
		@last = LastBlock.new(cells)
		@blocks = @clues.map{ |size| Block.new(size, @cells)}
		chain = [@first] + @blocks + [@last]
		chain[0..-2].each_with_index.map{ |block, i|
			block.next = chain[i+1]
		}
		chain[1..-1].each_with_index.map{ |block, i|
			block.prev = chain[i]
		}
		# p chain.map{|b|b.size}
	end

	def compact
		# r1 = @first.compact
		# p r1
		# r2 = @last.compact
		# p r2
		# return r1 && r2
		[@first, @last].all?(&:compact)
	end


	def intersections
		return @first.intersections
	end

	def gaps
		return @first.gaps
	end

	# get the size of the smallest matching block
	# for each continuous range of  black cells
	def minMaxPossibleSize
		blackRanges = getBlocksRanges{|cell| cell.state == :black}

		newInfo = []
		newCells = @cells.map{ |cell|
			Cell.new(cell.state == :white ? :white : :undefined)
		}

		blackRanges.map{|first, last|
			matchingCluesSizes = @blocks.select{ |blk|
				first.between?(blk.first, blk.last)
			}.map{ |blk| blk.size}


			if matchingCluesSizes.size == 0
				puts "why ?"
				puts @cells.map(&:to_s).join
			end

			blackSize = last - first + 1
			if blackSize == matchingCluesSizes.max
				[first-1, last+1].each { |info|
					if info.between?(0, @cells.size-1)
						if @cells[info].state == :undefined
							@cells[info].state = :white
							newInfo << info
						elsif @cells[info].state == :black
							puts "Something weird happen in minMaxPossibleSize at line #{__LINE__}"
						end
					end
				}
			elsif blackSize < (min = matchingCluesSizes.min)
				minClue = matchingCluesSizes.min

				# reset the cells
				newCells.map{|cell|
					cell.state = :undefined if cell.state == :black
				}

				# putting black cells on the current range
				newCells[first..last].each{ |cell|
					cell.state = :black
				}

				tmpBlocks = Blocks.new(newCells, [minClue])
				tmpBlocks.compact # no error here
				tmpBlocks.intersections.each { |info|
					if info.between?(0, @cells.size-1)
						if @cells[info].state == :undefined
							@cells[info].state = :black
							newInfo << info
						elsif @cells[info].state == :white
							p info
							puts "Something weird happen in minMaxPossibleSize at line #{__LINE__}"
						end
					end
				}
			end
		}


		return newInfo

	end

	# for each gaps (a set of undefined cells surround by white cells)
	def littleGapsInRange
		newInfo = [] # will contain all indexes with a new state
		# find the gaps
		undefineGaps = getBlocksRanges {|cell|
			cell.state == :undefined
		}.select{|first, last|
			[first - 1, last + 1].all? {|bound|
				bound.between?(0, @cells.size-1) && @cells[bound].state == :white
			}
		}

		# for each gaps:

		undefineGaps.each {|first, last|
			# find the matching clues, then find the smallest of them
			minClue = @blocks.select{ |blk|
				first.between?(blk.first, blk.last)
			}.map{ |blk| blk.size}.min

			# then fill the gap if its size is inferior to minClue
			size = last - first + 1

			if size < minClue
				[*first..last].each { |info|
					@cells[info].state = :white
					newInfo << info
				}
			end
		}

		return newInfo
	end

	def getBlocksRanges(&goodCell)
		ranges = []
		first = -1
		@cells.each_with_index { |cell, i|
			good = goodCell.call(cell, i)
			if good && first == -1
				first = i
			elsif !good && first != -1
				ranges << [first, i-1]
				first = -1
			end
		}
		if first != -1
			ranges << [first, @cells.size-1]
		end
		return ranges
	end
end # class Blocks
end # module Solver
