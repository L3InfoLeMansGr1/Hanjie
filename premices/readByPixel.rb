require 'rmagick'
include Magick




def generateGrid(imageName)
	image = ImageList.new(imageName)
	pos = 0
	columns = image.columns
	grid = Array.new()
	line = Array.new()
	image.each_pixel{ |pixel|
		line.push(pixel.isBlack?)
		pos+=1
		if(pos==columns)
			grid.push(line)
			line = Array.new
			pos=0
		end
	}
	return grid
end

class Magick::Pixel
	def isBlack?()
		(self.green==0 && self.red ==0 && self.blue == 0 )? true : false
	end
end

grid = generateGrid("apple.bmp")
puts grid.last.size
