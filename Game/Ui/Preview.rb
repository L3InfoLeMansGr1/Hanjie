class Preview
	@gtkObject

	attr_reader :gtkObject
	def initialize
		@gtkObject = Gtk::Label.new("Preview\n**Coming soon**")
	end
end
