require "pry"

class SelectionUi
	@selected
	@modified
	@normalColor
	@selectedColor

	def initialize(normalColor, selectedColor)
		@selected = []
		@modified = []
		@normalColor, @selectedColor = normalColor, selectedColor
	end

	def update(newSelection)

		unselected = @selected.reject { |widget|
			newSelection.include?(widget)
		}
		unselect(unselected)

		newlySelected = newSelection.reject { |widget|
			@selected.include?(widget)
		}
		select(newlySelected)

		@selected = newSelection

	end

	def unselect(arr)
		arr.each { |widget|
			@modified << widget
			# widget.override_background_color(nil, @normalColor)
			widget.override_background_color(nil, @normalColor)
			# widget.style.apply_default_background
		}
	end

	def select(arr)
		arr.each { |widget|
			@modified << widget
			# widget.modify_bg(Gtk::StateType::NORMAL, @selectedColor)
			# widget.pry
			widget.override_background_color(nil, @selectedColor)
		}
	end


	def show
		@modified.each(&:show)
		@modified = []
	end
end
