require 'rmagick'
include Magick

class Magick::Pixel
	def isBlack?()
		(self.green + self.red + self.blue) / 3 < (QuantumRange / 2)
	end
end

def groupeIndicesLigne(ligne)
	indices = []
	i = 0
	ligne.each_with_index{|etat,index|
		if etat then 
			i += 1
		end

		if (index == ligne.length-1 || !etat) && (i !=0) then 
			indices << i
			i = 0
		end
	}
	return indices
end

def groupeIndicesGrid(grid)
	indices = []
	grid.each{|ligne| indices << groupeIndicesLigne(ligne)}
	return indices
end

def afficherIndices(grid)
	i = 1
	grid.each{|g|
		print i," : ", g, "\n"
		i += 1
	}
end

def generateGrid(imageName)
	image = Image.read(imageName).first.crop!(0,0,150,130).resize_to_fill(15,15)
	image = image.quantize(256,GRAYColorspace)
	image = image.edge(1)
	image.write("test.jpg")
	grid = []
	image.each_pixel{|pixel| grid << !pixel.isBlack?}
	return grid.each_slice(image.columns).to_a
end

def ligneStr(ligne)
	ligne.map{|pix| pix ? "+":"  "}.join
end

def gridAfficher(grid)
	grid.each{|ligne| puts ligneStr(ligne)}
end

grid = generateGrid("apple.bmp")
gridAfficher(grid)

ind = groupeIndicesGrid(grid)
ind2 = groupeIndicesGrid(grid.transpose)
afficherIndices(ind)
puts ""
afficherIndices(ind2)	


