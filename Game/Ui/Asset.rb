class Asset
	@buffer
	def initialize(file)
		@buffer = GdkPixbuf::Pixbuf.new(file: file)
	end

	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(Gtk::Image.new(pixbuf: @buffer))
		widget.show_all
	end
end
