require "pry"

class SelectionUi
	@selected
	@modified

	def initialize
		@selected = []
		@modified = []
	end

	def update(newSelection)

		unselected = @selected.reject { |cell|
			newSelection.include?(cell)
		}
		unselect(unselected)

		newlySelected = newSelection.reject { |cell|
			@selected.include?(cell)
		}
		select(newlySelected)

		@selected = newSelection

	end

	def unselect(arr)
		arr.each { |cell|
			@modified << cell
			# # widget.override_background_color(nil, @normalColor)
			# widget.override_background_color(nil, @normalColor)
			# # widget.style.apply_default_background

			# coreCell = cell.coreCell
			# @assets.cell_asset(coreCell.state).applyOn(cell.gtkButton)
			cell.unselect

		}
	end

	def select(arr)
		arr.each { |cell|
			@modified << cell
			# # widget.modify_bg(Gtk::StateType::NORMAL, @selectedColor)
			# # widget.pry
			# widget.override_background_color(nil, @selectedColor)

			# coreCell = cell.coreCell
			# @assets.cell_asset_selected(coreCell.state).applyOn(cell.gtkButton)
			cell.select

		}
	end


	def show
		@modified.each(&:show)
		@modified = []
	end
end
