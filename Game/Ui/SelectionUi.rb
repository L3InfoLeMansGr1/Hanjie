class SelectionUi
	@selected
	@modified

	@@instance = nil

	# @@instance = new()
	private_class_method :new

	def self.getInstance()
		if @@instance == nil
			@@instance = new
		end
		return @@instance
	end

	def initialize
		@selected = []
		@modified = []

		# @@instances << self
	end

	def update(newSelection)

		# if newSelection != []
		# 	@@instances.each {|s|
		# 		s.update([])
		# 		s.show()
		# 	}
		# end

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

	
	def show
		@modified.each(&:show)
		@modified = []
	end

	private

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


end
