module Solver

class Solution

	attr_reader :rows, :cols

	def initialize(grid)
		@rows = grid
		@cols = grid.transpose
	end


	def to_s
		@rows.each_slice(5).map{ |rows|
			rows.map{ |row|
				# row.map(&:to_s).each_slice(5).map(&:join).join
				row.map(&:to_s).each_slice(5).map(&:join).join(" ")
			# }.join("\n")
			}.join("\n") + "\n"
		}.join("\n")
	end

	def clues
		return [@rows, @cols].map { |tracks|
			tracks.map { |track|
				Axe.new(track).showingClues
			}
		}

	end

end



end
