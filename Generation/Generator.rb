require File.dirname(__FILE__) + "/Picture"

class Generator

	GRIDS = {
		easy: [["apple.bmp", 1]],
		intermediate: [["apple.bmp", 1]],
		hard: [["apple.bmp",1],["bat.bmp",1]]
	}

	def self.get(difficulty)
		x = rand(GRIDS[difficulty].size)
		return Picture.creer(
			File.dirname(__FILE__) + "/../GridBank/" + GRIDS[difficulty][x][0],
			(difficulty == :easy ? 10 : difficulty == :intermediate ? 15 : 20),
			GRIDS[difficulty][x][1]
		)
	end
end
