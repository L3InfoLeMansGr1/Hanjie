require 'rmagick'
include Magick

class Magick::Pixel
	##
	# To know if the pixel is black or white
	#* *Returns* :
	# boolean
	def isBlack?()
		(self.green + self.red + self.blue) / 3 < (QuantumRange / 2)
	end
end

# Create a picture from an image and convert it to be playable in a picross game
class Picture

	@origine			# Source image
	@indicesLigne 		# Row clues
	@indicesColonne 	# Col clues
	@precision			# Precision of the pic
	@dimension 			# Dimension of the pic

	private_class_method :new
	attr_reader :precision
	attr_reader :indicesLigne
	attr_reader :indicesColonne

	def Picture.creer(imageName,dimension,precision)
		new(imageName,dimension,precision)
	end

	##
	# Create a picture from an image
	# * *Arguments* :
	# - +imageName+ -> Image's name
	# - +dimension+ -> Resize dimension that we want
	# - +precision+ -> Precision index (between 1 & 10)
	def initialize(imageName,dimension,precision)
		@origine = Image.read(imageName).first.resize_to_fill(dimension,dimension)
		@indicesLigne = []
		@indicesColonne = []
		@precision = precision
		@dimension = dimension
		calcIndice
	end

	##
	# Get a row clue with an index
	# * *Arguments* :
	# +i+ -> Index
	# * *Returns* :
	# row clue
	def getindicesLigne(i)
		return @indicesLigne[i]
	end

	##
	# Get a col clue with an index
	# * *Arguments* :
	# +i+ -> Index
	# * *Returns* :
	# col clue
	def getindicesColonne(i)
		return @indicesColonne[i]
	end

	##
	# Convert a picture into boolean arrays
	# * *Returns* :
	# boolean arrays which correspond to black or white pixels
	def toBoolean
		# image --> [true,true,false,true]					true = blanc
		#			[false,true,false,false]				false = noir
		# 			[true,true,true,true]

		grid = []
		image = toGrey(@precision)
		image.each_pixel{|pixel| grid << !pixel.isBlack?}
		grid.each_slice(image.columns).to_a
	end

	##
	# Set row and col clues from boolean arrays
	# * *Returns* :
	# boolean arrays
	def calcIndice
		# [true,true,false,true]				[2,1]
		# [false,true,false,false]		--> 	[1]
		# [true,true,true,false,true]			[3,1]

		grid = self.toBoolean
		@indicesLigne = groupeIndicesGrid(grid)
		@indicesColonne = groupeIndicesGrid(grid.transpose)
		return grid
	end

	##
	# Define the way to display a Picture
	def to_s
		toBoolean.map{|ligne| ligne.map{|pix| pix ? ".":" "}.join}.join("\n")
	end

	##
	# Print row and col clues
	def printIndice
		afficherIndices(@indicesLigne)
		print "\n\n"
		afficherIndices(@indicesColonne)
	end

	# PRIVATE CLASS

	##
	# Convert a picture in gray colorspace
	# * *Arguments* :
	# - +precision+ -> Precision we want
	# * *Returns* :
	# - The picture
	private
	def toGrey(precision)
		@origine.quantize(256,GRAYColorspace).edge(precision)
	end

	##
	# Convert boolean array into clues array
	# * *Arguments* :
	# - +ligne+ -> boolean array
	# * *Returns* :
	# - clues array
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

	##
	# Convert boolean arrays into clues arrays
	# * *Arguments* :
	# - +grid+ -> boolean arrays
	# * *Returns* :
	# - clues arrays
	def groupeIndicesGrid(grid)
		indices = []
		grid.each{|ligne| indices << groupeIndicesLigne(ligne)}
		return indices
	end

	##
	# Print clues arrays
	# * *Arguments* :
	# - +grid+ -> clues arrays
	def afficherIndices(grid)
		i = 1
		grid.each{|g|
			print i," : ", g, "\n"
			i += 1
		}
	end

end

if $0 == __FILE__

	i = Picture.creer("../GridBank/dolphin.png",60,1);
	puts i
	i.printIndice

end
