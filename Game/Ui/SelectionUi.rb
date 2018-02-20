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
			cell.unselect
		}
	end

	def select(arr)
		arr.each { |cell|
			@modified << cell
			cell.select
		}
	end


	def show
		@modified.each(&:show)
		@modified = []
	end
end
