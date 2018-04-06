require File.dirname(__FILE__) + "/../Game/Solver/Solver"

class RandomPic

	include Comparable

	def <=>(other)
		@grade <=> other.grade
	end

	@tab					# Booleens correspondant à la grille (array[array])
	@indicesLigne 			# Groupe d'indices de colonne (array[array])
	@indicesColonne 		# Groupe d'indices de ligne (array[array])
	@dimension 				# Dimension souhaité (5x5, 10x10, 15x15)
	@grade					# Note de difficulté de la grille

	private_class_method :new
	attr_reader :dimension, :indicesLigne, :indicesColonne, :grade

	def RandomPic.creer(dimension)
		new(dimension)
	end

	def initialize(dimension)
		@dimension = dimension
		@indiceLigne = []
		@indiceColonne = []
		@tab = randGenerator(dimension)
		calcIndice
		p indicesLigne
		p indicesColonne
		puts ""
		beUniqify
	end

	def calcIndice
		# [true,true,false,true]				[2,1]
		# [false,true,false,false]		--> 	[1]
		# [true,true,true,false,true]			[3,1]

		@indicesLigne = groupeIndicesGrid(@tab)
		@indicesColonne = groupeIndicesGrid(@tab.transpose)
		return @tab
	end

	def printIndice
		afficherIndices(@indicesLigne)
		print "\n\n"
		afficherIndices(@indicesColonne)
	end

	def to_s
		@tab.map{|l|
			l.map{|b|
				b ? "*":" "
			}.join

		}.join("\n")
	end

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

	def beUniqify
		res = Solver::Solver.uniqify(@indicesLigne,@indicesColonne)
		@indicesLigne = res[0]
		@indicesColonne = res[1]
		@grade = res[2]
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
