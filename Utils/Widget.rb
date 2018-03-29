class Widget
	@gtkObject

	def initialize(gtkObject)
		@gtkObject = gtkObject
	end

	attr_reader :gtkObject
	def show
		@gtkObject.show_all
	end
end
