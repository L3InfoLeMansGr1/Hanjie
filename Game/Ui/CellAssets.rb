require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/Assets"
require 'yaml'

class CellAssets < Assets

	@@cellAssetInstance = {}#Multi Singleton(one by size)
	@size                    	#The size of the grid
	@cellAssets
	@cellAssets_selected

	SIZE = {
		10 => "10x10",
		15 => "15x15",
		20 => "20x20"
	}

	private_class_method :new

	def CellAssets.getInstance(size)
		if @@cellAssetInstance[CellAssets::SIZE[size]] == nil then
			@@cellAssetInstance[CellAssets::SIZE[size]] = new(size)
		end
		return @@cellAssetInstance[CellAssets::SIZE[size]]
	end


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

	def cell_asset(state)
		@cellAssets[state]
	end

	def cell_asset_selected(state)
		@cellAssets_selected[state]
	end

	def cell_asset_frozen(state)
		@cellAssets_frozen[state]
	end

	##
	# type = "black", "white" or "cross"
	def pathToCell(type)
		return File.dirname(__FILE__) + "/../../Assets/" + @resolution +"/Common/Backgrounds/"+ @size +"/"+ type +".png"
	end

	##
	# color = black, white or cross
	def pathToSelectedCell(type)
		return  File.dirname(__FILE__) + "/../../Assets/" + @resolution +"/Common/Backgrounds/"+ @size +"/"+ @color +"/"+ type +"Selected.png"
	end

end
