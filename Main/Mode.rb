require File.dirname(__FILE__) + "/../Generation/Picture"
require File.dirname(__FILE__) + "/../Game/Core/Game"
require File.dirname(__FILE__) + "/../Game/Ui/CellAssets"
require File.dirname(__FILE__) + "/../Game/Ui/GridUi"
require File.dirname(__FILE__) + "/../Game/Core/Save"
require File.dirname(__FILE__) + "/../Game/Ui/PlayScreen/PlayScreen"

class Mode

	@rows
	@cols
	@gridUi
	@assets
	@game
	@playScreen
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
		if mode == "TimeTrial" then
			@playScreen = PlayScreen.new(@gridUi.gtkObject,2,120)
		else
			@playScreen = PlayScreen.new(@gridUi.gtkObject,1)
		end
		@playScreen.run
		@gtkObject = @playScreen.gtkObject
	end

	def initFromSave(path)
		save = Save.new(path)
		@rows = save.rows
		@cols = save.cols
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols,save)
		save.load(@game)
		@gridUi = GridUi.new(@game,@assets)
		puts save.mode
		if save.mode == "TimeTrial" then
			@playScreen = PlayScreen.new(@gridUi.gtkObject,2,120)
		else
			@playScreen = PlayScreen.new(@gridUi.gtkObject,1)
		end
		@playScreen.run
		@gtkObject = @playScreen.gtkObject
	end

	def onWin
	end

end
