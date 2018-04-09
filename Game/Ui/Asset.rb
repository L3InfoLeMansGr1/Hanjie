class Asset
	@buffer
	def initialize(file)
		@buffer = GdkPixbuf::Pixbuf.new(file: file)
		@file = file.split("/").last.split(".").first
		@images = []
	end

	def getImg
		if @images.size == 0
			puts "création d'une nouvelle image #{@file}"
			return Gtk::Image.new(pixbuf: @buffer)
		end

		puts "réutilisation d'une image #{@file}"
		return @images.shift
	end

	def delImg(widget)
		widget.each { |img|
			@images << img
			widget.remove(img)
		}
		self
	end

	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(getImg())
		widget.show_all
	end
end
