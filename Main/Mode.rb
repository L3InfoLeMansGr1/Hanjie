require File.dirname(__FILE__) + "/../Generation/Picture"
require File.dirname(__FILE__) + "/../Game/Core/Game"
require File.dirname(__FILE__) + "/../Game/Core/Chronometre"
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
	@time
	@countdown

	attr_reader :gtkObject, :countdown, :time

	def initialize(pic = nil,mode = "", level="",path = nil)
		pic ? initFromPic(pic,mode,level) : initFromSave(path)
	end


	def initFromPic(pic,mode,level)
		@rows = pic.indicesLigne
		@cols = pic.indicesColonne
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols,Save.new("",@rows,@cols,mode,level.to_s,@time),Chronometre.new(@countdown,@time))
		@gridUi = GridUi.new(@game,@assets)

		@playScreen = PlayScreen.new(@gridUi)

		@playScreen.run
		@gtkObject = @playScreen.gtkObject
	end

	def initFromSave(path)
		save = Save.new(path)
		@rows = save.rows
		@cols = save.cols
		@time = save.time
		@assets = CellAssets.getInstance(@rows.size)
		@game = Game.new(@rows,@cols,save,Chronometre.new(@countdown,@time))
		save.load(@game)
		@gridUi = GridUi.new(@game,@assets)
		@playScreen = PlayScreen.new(@gridUi)
		@playScreen.run
		@gtkObject = @playScreen.gtkObject
	end

	def onWin
		
	end

end
