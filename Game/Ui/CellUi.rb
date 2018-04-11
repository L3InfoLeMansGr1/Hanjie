
#Represents a cell in the grid
class CellUi

	@gtkObject											#The Gtk::EventBox containing the cell
	@row														#The abscissa of the cell
	@col 										 				#The ordinate of the cell
	@parent													#The GridUi object containing this CellUi
	@assets													#The CellAssets instance corresponding to the size of the grid
	@currentAsset										#The current image reprensenting the cell


	attr_reader :gtkObject, :row, :col

	##
	# Creates a CellUi object and generates its behavior
	# when clicked and entered
	# When clicking on a cellUi, checks if the mouse cursor is draged or not. Applies the right changes
	# When entering a cellUi while maintaining a click, adds the cell to the Selection
	# When entering a cellUi without clicking changes the apparence of the cell's row and col to help the player
	# * *Arguments* :
	#   - +parent+ -> The GridUi object containing this CellUi
	#   - +row+ -> The abscissa of the cell
	#   - +col+ -> The ordinate of the cell
	#   - +assets+ -> The CellAssets instance corresponding to the size of the grid
	def initialize(parent, row, col, assets)
		@row = row
		@col = col
		@parent = parent
		@assets = assets
		@currentAsset = nil

		@gtkObject = Gtk::EventBox.new
		normal()

		@gtkObject.signal_connect("button_press_event") { |_, event|
			@parent.beginDrag(self, event.button)
			Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
		}
		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			if @parent.draged?
				@parent.selection(self)
			else
				@parent.hover(self)
			end
		}
	end

	##
	# Returns the Cell object corresponding to this CellUi object in the grid
	def coreCell
		@parent.coreCellAt(@row, @col)
	end

	##
	# Applies the secondary change on the cell
	# @see Cell
	def rightClicked
		coreCell.secondaryChange()
	end

	##
	# Applies the primary change on the cell
	# @see Cell
	def leftClicked
		coreCell.primaryChange()
	end

	##
	# Changes the appearance of the cell to its selected aspect
	def select
		if @currentAsset != nil
			@currentAsset.delImg(@gtkObject);
		end
		@currentAsset = @assets.cell_asset_selected(coreCell.state)
		applyAsset()
	end

	##
	# Changes the appearance of the cell to is normal aspect
	def normal
		if @currentAsset != nil
			@currentAsset.delImg(@gtkObject);
		end
		if coreCell.frozen?
			@currentAsset = @assets.cell_asset_frozen(coreCell.state)
		else
			@currentAsset = @assets.cell_asset(coreCell.state)
		end
		applyAsset()
	end

	alias :unselect :normal

	##
	# Checks if the cell in arguments has the same state as self
	# * *Arguments* :
	#   - +cell+ -> another CellUi object
	# * *Returns* :
	#   -true if both states are the same, false if not
	def sameState?(cell)
		cell.coreCell.state == coreCell.state
	end

	##
	# refreshes the appearance of the CellUi object
	# also refreshes the preview
	def applyAsset
		@currentAsset.applyOn(@gtkObject)
		@parent.preview.update(@row, @col, coreCell.state)
	end

	##
	# Allows the cell to be seen
	def show
		@gtkObject.show
	end
end
