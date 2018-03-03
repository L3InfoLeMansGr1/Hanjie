require "./Generation/Picture"

class Generator

	GRIDS = {
		easy: ["apple.bmp"],
		intermediate: ["apple.bmp"],
		hard: ["apple.bmp"]
	}

	def Generator.get(difficulty)
		x = rand(GRIDS[difficulty].size)
		return Picture.creer("./GridBank/"+GRIDS[difficulty][x],(difficulty == :easy ? 10 : difficulty == :intermediate ? 15 : 20))
	end
end
