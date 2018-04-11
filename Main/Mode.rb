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
	@chrono

	attr_reader :gtkObject, :countdown, :time

	def initialize(pic = nil,mode = "", level="",path = nil)
		pic ? initFromPic(pic,mode,level) : initFromSave(path)
	end


	def initFromPic(pic,mode,level)
		@rows = pic.indicesLigne
		@cols = pic.indicesColonne
		@assets = CellAssets.getInstance(@rows.size)
		@chrono = Chronometre.new(@countdown,@time)
		@game = Game.new(@rows,@cols,Save.new("",@rows,@cols,mode,level.to_s,@time),@chrono)
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
		@chrono = Chronometre.new(@countdown,@time)
		@game = Game.new(@rows,@cols,save,@chrono)
		save.load(@game)
		@gridUi = GridUi.new(@game,@assets)
		@gridUi.cells.each { |row|
			row.each { |cell|
				@gridUi.clicked(cell)
			}
		}

		@playScreen = PlayScreen.new(@gridUi)
		@playScreen.run
		@gtkObject = @playScreen.gtkObject
	end


end
