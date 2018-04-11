require File.dirname(__FILE__) + "/../Game/Solver/Solver"

# Create a random binary picture
class RandomPic

	include Comparable

	@tab					# Boolean matrix
	@indicesLigne 			# Row clues
	@indicesColonne 		# Col clues
	@dimension 				# Dimension of the pic
	@grade					# Picture's grade

	private_class_method :new
	attr_reader :dimension, :indicesLigne, :indicesColonne, :grade

	def <=>(other)
		@grade <=> other.grade
	end

	def RandomPic.creer(dimension)
		new(dimension)
	end

	##
	# Create a random picture, ready to play in a picross game
	# * *Arguments* :
	# - +dimension+ -> Resize dimension that we want
	def initialize(dimension)
		@dimension = dimension
		@indiceLigne = []
		@indiceColonne = []

		loop do
			@tab = randGenerator(dimension)
			calcIndice
			break if (biggestAxe < 8)
		end

		beUniqify
	end

	##
	# Set row and col clues from boolean arrays
	# * *Returns* :
	# boolean arrays
	def calcIndice
		# [true,true,false,true]				[2,1]
		# [false,true,false,false]		--> 	[1]
		# [true,true,true,false,true]			[3,1]

		@indicesLigne = groupeIndicesGrid(@tab)
		@indicesColonne = groupeIndicesGrid(@tab.transpose)
		return @tab
	end

	##
	# Print row and col clues
	def printIndice
		afficherIndices(@indicesLigne)
		print "\n\n"
		afficherIndices(@indicesColonne)
	end

	##
	# Define the way to display a Picture
	def to_s
		@tab.map{|l|
			l.map{|b|
				b ? "*":" "
			}.join

		}.join("\n")
	end

	##
	# Create boolean matrix with the dimension given
	# * *Returns* :
	# boolean matrix
	def randGenerator(dimension)
		r = Random.new
		fullTab = []
		tmpTab = []
		dimension.times do
			dimension.times do
				nb = r.rand(0..1)
				if nb == 0 then tmpTab << false else tmpTab << true end
			end
			fullTab << tmpTab
			tmpTab = []
		end
		return fullTab
	end

	##
	# Make the picture unique (1 way to solve) & give a grade for this picture
	def beUniqify
		res = Solver::Solver.uniqify(@indicesLigne,@indicesColonne)
		@indicesLigne = res[0]
		@indicesColonne = res[1]
		@grade = res[2]
	end

	##
	# Determine the biggest axe in the matrix (number of clue)
	# * *Returns* :
	# The size of the biggest axe
	def biggestAxe
		maxL = @indicesLigne.map(&:size).max
		maxC = @indicesColonne.map(&:size).max
		return [maxL,maxC].max
	end

#### PRIVATE CLASS ####

	private
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

if $0 == __FILE__

	i = RandomPic.creer(20)
	i.printIndice
	puts i

end
