require File.dirname(__FILE__) + "/Axes"
require File.dirname(__FILE__) + "/Cell"
require File.dirname(__FILE__) + "/Solution"
require File.dirname(__FILE__) + "/StrategieUnify"


module Solver
class Solver
	@grid       	# a simple grid containing all the cells
	@gridT       	# the transposition of the grid
	@rowsBlocks 	# the clues for the rows
	@colsBlocks 	# the clues for the cols
	@rows       	# all the axes in rows
	@cols       	# all the axes in cols
	@solutions  	# all the solutions
	@callCount  	# number of call to Track::solve

	@@betsCount
	@@callCount

	def self.initCount
		@@betsCount = 0
		@@callCount = 0
	end


	def self.uniqify(rows, cols, strat=StrategieUnifyAnyBlack)


		solver = Solver.new(rows, cols)
		self.initCount()
		sols = solver.solve

		while (sols.size > 1)
			#puts "again"
			sols[0].rows.zip(*sols[1..-1].map(&:rows)).each { |everyNthRow|
				everyNthRow[0].zip(*everyNthRow[1..-1]).each { |everyIJCell|
					everyIJCell[0].state = strat.getState(everyIJCell)
				}
			}
			rows, cols = sols[0].clues


			solver = Solver.new(rows, cols)
			self.initCount()
			sols = solver.solve

		end

		return [rows, cols, solver.grade]
	end

	def grade
		# 4 * @@betsCount ** 2 + (@@callCount * 1.0) / ((@rowsBlocks.size + @colsBlocks.size) * 1.0)
		@@betsCount
	end

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
			@@callCount += 1
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
			# p "BETS"
			return [] if @@betsCount > 100
			@@betsCount += 1
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
			count = line.count{|cell| cell.state == :white}
			count = count == 0 ? @cols.size : count
			[count, index]
		}.min[1]

		colIndex = @gridT.each_with_index.select{ |col, index|
			col[lineIndex].state == :white
		}.map{|col, index|
			count = col.count{|cell| cell.state == :white}
			[count, index]
		}.min[1]

		return [:black, :cross].map{|state| [lineIndex, colIndex, state]}
	end

	def solved?
		return [@rows, @cols].all?(&:solved?)
	end
end # class Solver
end # module Solver

if $0 == __FILE__


	# rows = [[3,1,1], []]
	# cols = [[1],[1],[1],[],[1],[],[1]]

	rows = [
		[12, 14],
		[11, 6, 15],
		[3, 40],
		[3, 36, 2],
		[2, 1, 34, 4, 1],
		[4, 1, 31, 2],
		[4, 1, 29, 1, 4],
		[4, 2, 6, 8, 1, 3],
		[6, 2, 4, 1, 6],
		[1, 2, 2, 1, 5],
		[3, 2, 2, 4, 1],
		[3, 1, 2, 1, 1, 6, 1],
		[1, 2, 1, 2, 2, 2, 2, 7, 1],
		[7, 2, 2, 2, 2, 1, 1, 4, 2],
		[1, 4, 7, 2, 2, 12, 2],
		[2, 7, 2, 1, 2, 3, 3, 2],
		[2, 10, 2, 2, 7, 1, 4],
		[1, 5, 1, 2, 1, 6, 2, 1],
		[1, 5, 2, 3, 8, 3],
		[2, 4, 1, 2, 1, 1, 2, 6, 3],
		[1, 2, 1, 4, 3, 1, 4, 3],
		[2, 1, 3, 3, 2, 1, 2, 1, 2, 3],
		[2, 2, 2, 2, 1, 3, 2, 3],
		[1, 5, 1, 1, 1, 1, 2, 2, 4],
		[1, 7, 2, 1, 2, 2, 1, 2, 3],
		[17, 1, 3, 2, 3, 2, 1, 3],
		[1, 11, 3, 2, 1, 3, 15, 2],
		[2, 12, 4, 4, 16, 2],
		[2, 5, 5, 20, 3],
		[2, 2, 4, 4, 5, 5, 3],
		[2, 2, 3, 4, 4, 3],
		[2, 1, 3, 4, 4, 1, 1, 6],
		[3, 2, 2, 4, 5, 3, 2, 1, 6],
		[3, 2, 3, 4, 4, 2, 2, 8],
		[4, 2, 5, 3, 4, 7, 3, 2, 4],
		[4, 4, 2, 7, 6, 4, 2],
		[4, 1, 1, 6, 1, 2, 4],
		[5, 1, 2, 6],
		[5, 5, 1, 2, 1, 4, 1, 2],
		[6, 7, 2, 2, 1, 8],
		[7, 10, 2, 12],
		[7, 11, 14],
		[9, 10, 16, 1],
		[7, 2, 10, 15],
		[8, 9, 13, 2, 1],
		[6, 9, 11, 1, 4, 1],
		[6, 22, 3, 2],
		[6, 14, 1, 3],
		[6, 11, 1, 1, 2],
		[6, 5, 5, 2, 4, 5]
	]
	cols = [
		[1, 29],
		[1, 5, 2, 1, 2, 1, 18],
		[1, 7, 3, 14],
		[1, 1, 5, 5, 16],
		[2, 4, 5, 13],
		[3, 1, 2, 2, 2, 5, 11],
		[3, 1, 7, 3, 5, 1, 10],
		[4, 1, 4, 2, 1, 3, 5, 5, 8],
		[5, 1, 3, 4, 4, 4, 2, 1, 1, 4],
		[6, 2, 3, 4, 3, 2, 2],
		[7, 2, 1, 4, 4, 2, 4, 1],
		[7, 2, 6, 8, 4, 3],
		[8, 2, 4, 1, 5, 3, 5, 2],
		[7, 6, 1, 1, 2, 2, 8],
		[7, 4, 1, 2, 5, 2, 9],
		[6, 3, 8, 1, 8, 1],
		[6, 5, 3, 2, 10],
		[6, 3, 1, 2, 1, 10],
		[5, 1, 1, 3, 13],
		[5, 11, 10, 1, 11],
		[5, 5, 4, 10, 3, 3],
		[6, 3, 9, 2, 4],
		[6, 1, 1, 1, 6, 1, 4],
		[6, 2, 4],
		[6, 7, 1, 4],
		[6, 1, 1, 1, 2, 8, 8],
		[6, 1, 2, 12, 8],
		[5, 9, 11, 1, 9],
		[5, 21, 10],
		[5, 2, 2, 1, 6],
		[6, 1, 2, 3, 1, 6],
		[6, 5, 4, 2, 1, 7],
		[7, 3, 1, 5, 2, 8],
		[7, 4, 3, 1, 3, 3, 7, 1],
		[7, 3, 2, 1, 4, 3, 7, 1],
		[8, 3, 5, 2, 6, 3, 7, 2],
		[8, 1, 6, 5, 3, 6],
		[8, 1, 8, 7, 1, 3, 7],
		[7, 1, 4, 4, 2, 4, 4, 5],
		[6, 1, 5, 1, 3, 3, 6, 4, 2],
		[5, 4, 1, 6, 4, 9, 1, 2, 1],
		[5, 1, 5, 1, 6, 5, 1, 2, 2, 1],
		[4, 5, 2, 9, 4, 3, 1],
		[3, 2, 2, 6, 2, 1, 2],
		[3, 1, 5, 8, 1, 1],
		[2, 5, 2, 5, 3],
		[2, 5, 2, 1, 4, 4],
		[2, 2, 1, 10, 7, 4, 1],
		[2, 1, 4, 18, 1],
		[2, 1, 25]
	]

	rows, cols, grade = Solver::Solver.uniqify(rows, cols)
	p rows
	p cols
	p grade
	# puts





end
