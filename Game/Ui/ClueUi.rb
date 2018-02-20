class ClueUi
	@blocks
	@index
	@gtkButton
	@gtkLabels

	attr_reader :gtkButton
	def initialize(orientation, blocks, index)
		@blocks = blocks
		@index = index

		gtkBox = Gtk::Box.new(orientation)
		@gtkLabels = blocks.map { |length|
			label = Gtk::Label.new(length.to_s)
			gtkBox.pack_end(label, expand:false, fill:false, padding:3)
			label
		}
		@gtkButton = Gtk::Button.new
		@gtkButton.add(gtkBox)
	end

	def swap

	end



end
