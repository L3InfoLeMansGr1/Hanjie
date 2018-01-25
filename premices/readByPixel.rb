require 'rmagick'
include Magick

class Magick::Pixel
	def isBlack?()
		(self.green + self.red + self.blue) / 3 < (QuantumRange / 2)
	end
end

def generateGrid(imageName)
	image = Image.read(imageName).first#.crop!(0,0,150,130).resize_to_fill(50,50)
	image = image.quantize(256,GRAYColorspace)
	image = image.edge(5)
	image.write("test.jpg")
	grid = []
	image.each_pixel{|pixel| grid << !pixel.isBlack?}
	return grid.each_slice(image.columns).to_a
end

def ligneStr(ligne)
	ligne.map{|pix| pix ? "##":"  "}.join
end

def gridAfficher(grid)
	grid.each{|ligne| puts ligneStr(ligne)}
end

grid = generateGrid("repas.png")
gridAfficher(grid)	


