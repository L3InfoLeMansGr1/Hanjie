require File.dirname(__FILE__) + "/Axes"
require File.dirname(__FILE__) + "/Cell"
require File.dirname(__FILE__) + "/Solution"


module Solver
class Solver
	@grid       	# a simple grid containing all the cells
	@gridT       	# the transposition of the grid
	@rowsBlocks 	# the clues for the rows
	@colsBlocks 	# the clues for the cols
	@rows       	# all the axes in rows
	@cols       	# all the axes in cols
	@solutions  	# all the solutions

	def initialize(rowsBlocks, colsBlocks, grid=nil, bet=nil)
		if (grid == nil || bet == nil) && grid != bet
			STDERR.puts "WARNING: if you give a grid to the solver, you need to give a bet too"
			# grid = bet = nil
		end

		@rowsBlocks = rowsBlocks
		@colsBlocks = colsBlocks

		nC, nR = colsBlocks.size, rowsBlocks.size
		if grid == nil
			@grid = [*1..nR].map{[*1..nC].map{Cell.new}}
		else
			@grid = grid
		end

		@gridT = @grid.transpose

		@rows = Axes.new(@grid, rowsBlocks)
		@cols = Axes.new(@gridT, colsBlocks)

		@solutions = []

		if bet != nil
			r, c, state = bet
			@grid[r][c].state = state
			@rows.addAxe(r)
			@cols.addAxe(c)
		else
			@rows.addAll
			@cols.addAll
		end
	end

	def solve
		nR, nC = @rows.queueSize, @cols.queueSize
		while nR != 0 || nC != 0
			axes, others = nR > nC ? [@rows, @cols] : [@cols, @rows]
			updates = axes.solve
			# p updates
			if updates == [-1]
				return [] # the solver encounter an impossibility
			end
			updates.map{ |updatedIndex|
				others.addAxe(updatedIndex)
			}
			nR, nC = @rows.queueSize, @cols.queueSize
			# showGrid()
		end

		if solved?
			@solutions << Solution.new(@grid)
		else
			p "BETS"
			chooseBets.map{|row, col, state|
				branch(row, col, state)
			}
		end
		@solutions
	end

	def to_s
		# @solutions.map{ |sol|
		# 	sol.each_slice(5).map{ |rows|
		# 		rows.map { |row|
		# 			row.map(&:to_s).each_slice(5).map(&:join).join(" ")
		# 		}.join("\n") + "\n"
		# 	}.join("\n")
		# }.join("\n\n")

		@solutions.map(&:to_s).join("\n\n")
	end

	def showGrid

		puts @grid.each_slice(5).map{ |rows|
			rows.map{ |row|
				row.map(&:to_s).each_slice(5).map(&:join).join(" ")
			}.join("\n") + "\n"
		}.join("\n")
		# print "press Enter "
		# gets
		puts
	end

	private
	def copyGrid
		@grid.map{ |row|
			row.map{ |cell|
				Cell.new(cell.state)
			}
		}
	end

	def branch(rowi, coli, state)
		sols = Solver.new(@rowsBlocks, @colsBlocks, copyGrid(), [rowi, coli, state]).solve()
		sols.each { |sol| @solutions << sol }
	end

	def chooseBets
		lineIndex = @grid.each_with_index.map{|line, index|
			count = line.count{|cell| cell.state == :undefined}
			count = count == 0 ? @cols.size : count
			[count, index]
		}.min[1]

		colIndex = @gridT.each_with_index.select{ |col, index|
			col[lineIndex].state == :undefined
		}.map{|col, index|
			count = col.count{|cell| cell.state == :undefined}
			[count, index]
		}.min[1]

		return [:black, :white].map{|state| [lineIndex, colIndex, state]}
	end

	def solved?
		return [@rows, @cols].all?(&:solved?)
	end
end # class Solver
end # module Solver

if $0 == __FILE__

	# require "../Game"


	# [Game.site].each {|rows, cols|
	# 	# [Game.xs].each {|rows, cols|
	# 	# [Game.cat].each {|rows, cols|
	# 	solver = Solver::Solver.new(rows, cols)
	# 	solver.solve
	#
	# 	puts solver
	# 	# for sol in sols
	# 	# 	rows = sol.rows
	# 	# 	# if [[8,18], [16,11]].all? { |i, j| rows[i][j].state == :black}
	# 	# 	# 	puts sol
	# 	# 	# 	puts
	# 	# 	# 	puts
	# 	# 	# end
	# 	# end
	# 	puts
	# }





end
