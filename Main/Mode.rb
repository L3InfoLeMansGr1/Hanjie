require File.dirname(__FILE__) + "/../Generation/Picture"
require File.dirname(__FILE__) + "/../Game/Core/Game"
require File.dirname(__FILE__) + "/../Game/Ui/CellAssets"
require File.dirname(__FILE__) + "/../Game/Ui/GridUi"

class Mode

	@rows
	@cols
	@gridUi
	@assets
	@game
	@gtkObject

	attr_reader :gtkObject

	def initialize(pic)
		@rows = pic.indicesLigne
		@cols = pic.indicesColonne
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
