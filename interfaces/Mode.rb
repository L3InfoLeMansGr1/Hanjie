require "./Generation/Picture"
require "./Game/Core/Game"
require "./Game/Ui/Assets"
require "./Game/Ui/GridUi"

class Mode

	@rows
	@cols
	@gridUi
	@assets
	@game
	@gtkObject

	attr_reader :gtkObject

	def initialize(pic)
		@rows = pic.indicesV
		@cols = pic.indicesH
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols)
		@gridUi = GridUi.new(@game,@assets)
		@gtkObject = @gridUi.gtkObject
	end

	def onWin
	end

	def initGrid
	end
end
