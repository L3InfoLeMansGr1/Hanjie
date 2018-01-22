require 'rmagick'
include Magick

img = ImageList.new("tour-eiffel.jpg")[0]



img.each_pixel{ |i|
	puts i
}

p img.rows
p img.columns
