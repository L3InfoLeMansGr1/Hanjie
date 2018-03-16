require "./Generation/Picture"

class Generator

	GRIDS = {
		easy: ["apple.bmp"],
		intermediate: ["apple.bmp"],
		hard: [["apple.bmp",1],["bat.bmp",1]]
	}

	def Generator.get(difficulty)
		x = rand(GRIDS[difficulty].size)
		return Picture.creer("./GridBank/"+GRIDS[difficulty][x][0],(difficulty == :easy ? 10 : difficulty == :intermediate ? 15 : 20),GRIDS[difficulty][x][1])
	end
end
