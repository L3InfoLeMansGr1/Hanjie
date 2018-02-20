class ClueUi
	@blocks
	@index
	@gtkObject
	@gtkLabels

	attr_reader :gtkObject
	def initialize(orientation, blocks, index)
		@blocks = blocks
		@index = index

		gtkBox = Gtk::Box.new(orientation)
		@gtkLabels = blocks.reverse.map { |length|
			label = Gtk::Label.new(length.to_s)
			gtkBox.pack_end(label, expand:false, fill:false, padding:3)
			label
		}
		@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end

	def swap

	end



end
