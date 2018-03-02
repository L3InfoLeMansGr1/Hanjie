class Preview
	@gtkObject

	attr_reader :gtkObject
	def initialize
		@gtkObject = Gtk::Label.new(
			"______Preview______" + "\n" +
			"___**Coming soon**___"
		)
	end
end
