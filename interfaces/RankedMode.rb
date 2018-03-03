require "./interfaces/Mode"
require "./Generation/Picture"

class RankedMode < Mode

	def initialize(difficulty)
		initGrid(difficulty)
	end

	def initGrid(difficulty)
		#En fonction de la difficulté demander a generation
		pic = Picture.creer("./Generation/apple.bmp",10)
		@rows = pic.indicesV
		@cols = pic.indicesH
		@assets = Assets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols)
		@gridUi = GridUi.new(@game,@assets)
		@gtkObject = @gridUi.gtkObject
	end

	def onWin
		#Verifier si le score est a ajouter ou pas, si oui demander a l'utilisateur d'entrer son nom
		#et ajouter le score
	end

end
