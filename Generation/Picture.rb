require 'rmagick'
include Magick

class Magick::Pixel
	def isBlack?()
		(self.green + self.red + self.blue) / 3 < (QuantumRange / 2)
	end
end

class Picture

	@origine
	@indicesH
	@indicesV
	@precision

	private_class_method :new
	attr_reader :indicesV, :indicesH, :precision

	def Picture.creer(imageName)
		new(imageName)
	end

	def initialize(imageName)
		@origine = Image.read(imageName).first
		@indicesH = []
		@indicesV = []
		@precision = 1
	end

	def toBoolean
		# image --> [true,true,false,true]					true = blanc
		#			[false,true,false,false]				false = noir
		# 			[true,true,true,true]

		grid = []
		image = toGrey(@precision)
		image.each_pixel{|pixel| grid << !pixel.isBlack?}
		grid.each_slice(image.columns).to_a
	end

	def calcIndice
		# [true,true,false,true]				[2,1]		
		# [false,true,false,false]		--> 	[1]		
		# [true,true,true,false,true]			[3,1]

		grid = self.toBoolean
		@indicesH = groupeIndicesGrid(grid)
		@indicesV = groupeIndicesGrid(grid.transpose)
		return grid
	end

	def to_s
		toBoolean.map{|ligne| ligne.map{|pix| pix ? "++":"  "}.join}.join("\n")
	end

	def printIndice
		afficherIndices(indicesH)
		print "\n\n"
		afficherIndices(indicesV)
	end

	# PRIVATE CLASS

	private
	def toGrey(precision)
		@origine.quantize(256,GRAYColorspace).edge(precision)
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

end

i = Picture.creer("apple.bmp")
puts i
i.calcIndice
i.printIndice