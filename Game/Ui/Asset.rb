
#Representation of an Asset, an Asset is an image witch is applied on a widget
class Asset

	@buffer #The GdkPixbuf::Pixbuf containing the image

	##
	# Creates a new Asset object
	# * *Arguments* :
	#   - +file+     -> The path to the Image
	def initialize(file)
		@buffer = GdkPixbuf::Pixbuf.new(file: file)
		@file = file.split("/").last.split(".").first
		@images = []
	end

	##
	# Returns a Gtk::Image containing this image
	# * *Returns* :
	#   - the Gtk::Image
	def getImg
		if @images.size == 0
			# puts "création d'une nouvelle image #{@file}"
			return Gtk::Image.new(pixbuf: @buffer)
		end

		# puts "réutilisation d'une image #{@file}"
		return @images.shift
	end

	##
	# Removes this Asset from the given widget
	# * *Arguments* :
	#   - +widget+     -> The widget to remove from
	# * *Returns* :
	#   - this Asset
	def delImg(widget)
		widget.each { |img|
			@images << img
			widget.remove(img)
		}
		self
	end

	##
	# Applies this Asset on the given widget
	# * *Arguments* :
	#   - +widget+     -> The widget to apply on
	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(getImg())
		widget.show_all
	end
end
