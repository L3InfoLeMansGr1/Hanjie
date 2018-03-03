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

	def onWin
	end

	def initGrid
	end
end
