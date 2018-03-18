require File.dirname(__FILE__) + "/../Generation/Picture"
require File.dirname(__FILE__) + "/../Game/Core/Game"
require File.dirname(__FILE__) + "/../Game/Ui/CellAssets"
require File.dirname(__FILE__) + "/../Game/Ui/GridUi"
require File.dirname(__FILE__) + "/../Game/Core/Save"

class Mode

	@rows
	@cols
	@gridUi
	@assets
	@game
	@gtkObject

	attr_reader :gtkObject


	def initialize(pic = nil,mode = "", level="",path = nil)
		pic ? initFromPic(pic,mode,level) : initFromSave(path)
	end


	def initFromPic(pic,mode,level)
		@rows = pic.indicesLigne
		@cols = pic.indicesColonne
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols,Save.new("",@rows,@cols,mode,level.to_s))
		@gridUi = GridUi.new(@game,@assets)
		@gtkObject = @gridUi.gtkObject
	end

	def initFromSave(path)
		save = Save.new(path)
		@rows = save.rows
		@cols = save.cols
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols,save)
		save.load(@game)
		@gridUi = GridUi.new(@game,@assets)
		@gtkObject = @gridUi.gtkObject
	end

	def onWin
	end

end
