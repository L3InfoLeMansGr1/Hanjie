require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/Assets"
require 'yaml'



class CellAssets < Assets

	@@cellAssetInstance = {}				#here to allow a single instance of cellAsset per grid size
	@size                    				#The size of the grid
	@cellAssets											#The assets for a cell
	@cellAssets_selected						#the assets for a cell when it is selected
	@cellAssest_frozen							#the assets for a cell when it is frozen

	SIZE = {
		10 => "10x10",
		15 => "15x15",
		20 => "20x20"
	}

	private_class_method :new

	##
	# Allows for only a single instance of CellAssets to be created per grid size
	# * *Arguments* :
	#   - +size+ -> the size of the grid (10, 15 or 20)
	def CellAssets.getInstance(size)
		if @@cellAssetInstance[CellAssets::SIZE[size]] == nil then
			@@cellAssetInstance[CellAssets::SIZE[size]] = new(size)
		end
		return @@cellAssetInstance[CellAssets::SIZE[size]]
	end

	##
	# Uses the initialize method of the Assets class to get the language, color, resolution of the game
	# Then generates assets for each possible state of a cell in the grid
	# * *Arguments* :
	#   - +size+ -> the size of the grid (10, 15 or 20)
	def initialize(size)
		super()
		@size = CellAssets::SIZE[size]
		@cellAssets = {
			white: Asset.new(pathToCell("white")),
			black: Asset.new(pathToCell("black")),
			cross: Asset.new(pathToCell("cross"))
		}
		@cellAssets_selected = {
			white: Asset.new(pathToSelectedCell("white")),
			black: Asset.new(pathToSelectedCell("black")),
			cross: Asset.new(pathToSelectedCell("cross"))
		}
		@cellAssets_frozen = {
			white: Asset.new(pathToCell("whiteFrozen")),
			black: Asset.new(pathToCell("blackFrozen")),
			cross: Asset.new(pathToCell("crossFrozen"))
		}
	end

	##
	# Getter function
	# * *Arguments* :
	#   - +state+ -> the state of the cell [:black, :white:, crossed]
	# * *Returns* :
	#   -The normal asset for a cell, depending on its state
	def cell_asset(state)
		@cellAssets[state]
	end

	##
	# Getter function
	# * *Arguments* :
	#   - +state+ -> the state of the cell [:black, :white:, :crossed]
	# * *Returns* :
	#   -The selected asset for a cell, depending on its state
	def cell_asset_selected(state)
		@cellAssets_selected[state]
	end

	##
	# Getter function
	# * *Arguments* :
	#   - +state+ -> the state of the cell [:black, :white:, :crossed]
	# * *Returns* :
	#   -The frozen asset for a cell, depending on its state
	def cell_asset_frozen(state)
		@cellAssets_frozen[state]
	end

	##
	# Getter function
	# * *Arguments* :
	#   - +state+ -> the state of the cell ["black", "white", "cross"]
	# * *Returns* :
	#   -The path to the image file representing the cell
	def pathToCell(state)
		return File.dirname(__FILE__) + "/../../Assets/" + @resolution +"/Common/Backgrounds/"+ @size +"/"+ state +".png"
	end

	##
	# Getter function
	# * *Arguments* :
	#   - +state+ -> the state of the cell ["black", "white", "cross"]
	# * *Returns* :
	#   -The path to the image file representing the selected cell
	def pathToSelectedCell(state)
		return  File.dirname(__FILE__) + "/../../Assets/" + @resolution +"/Common/Backgrounds/"+ @size +"/"+ @color +"/"+ state +"Selected.png"
	end

end
