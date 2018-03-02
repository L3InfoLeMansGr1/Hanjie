

class CellUi

	attr_reader :gtkObject, :row, :col
	def initialize(parent, row, col, assets)
		@row = row
		@col = col
		@parent = parent
		@assets = assets

		@gtkObject = Gtk::EventBox.new
		normal()

		@gtkObject.signal_connect("button_press_event") { |_, event|
			@parent.beginDrag(self, event.button)
			Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
		}
		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			if @parent.draged?
				@parent.selection(self)
			end
		}
	end

	def to_s
		"(r#{@row}, c#{@col})"
	end

	def say(msg)
		puts "Cell #{self}: #{msg}"
	end

	def rightClicked
		coreCell.secondaryChange()
		normal()
		show()
	end

	def leftClicked
		coreCell.primaryChange()
	end

	def coreCell
		@parent.coreCellAt(@row, @col)
	end

	def select
		selected_asset = @assets.cell_asset_selected(coreCell.state)
		applyAsset(selected_asset)
	end

	def normal
		normal_asset = @assets.cell_asset(coreCell.state)
		applyAsset(normal_asset)
	end

	alias :unselect :normal

	def sameState?(cell)
		cell.coreCell.state == coreCell.state
	end

	def applyAsset(asset)
		asset.applyOn(@gtkObject)
		@parent.preview.update(@row, @col, coreCell.state)
	end

	def show
		@gtkObject.show
	end
end
