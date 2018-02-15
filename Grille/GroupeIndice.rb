

load '../Grille/Cellule.rb'
load '../Grille/Grille.rb'
require '../Constants.rb'


class GroupeIndice

	#@tabIndice				Contient les indices des cases à colorier
	#@somme					Contient la somme des indices ET la somme des espaces ( [2, 2, 2] dans le tabIndice donnerait un 2+1+2+1+2 = 8)
	#@isTabindiceDisplay

	attr_reader :tabIndice
	attr_reader :somme
	private_class_method :new

	##
	# Prend une ligne ou une colonne de Cellule d'une Grille
	# @see Grille
	# @see Cellule
	#
	def initialize(lc)
		sum = 0
		@tabIndice = lc;
		lc.each{|i| sum += i}
		@somme = sum	
	end

	##
	# Prend une ligne ou une colonne de Cellule d'une Grille
	# @see Grille
	# @see Cellule
	#
	def GroupeIndice.creer(lc)
		new(lc)
	end

	def to_s()
		s = ""
		@tabIndice.each { |e|
			s += "#{e} "
		}
		return s + "somme : "+@somme.to_s
	end

	def toggle
		@isTabindiceDisplay = !@isTabindiceDisplay
		return @isTabindiceDisplay
	end

end #Class GroupeIndice

# Tests
# A virer une fois testé

# Que des blanches
# c1  = Cellule.creer(1, true)
# c2  = Cellule.creer(1, true)
# c3  = Cellule.creer(1, true)
# c4  = Cellule.creer(1, true)
# c5  = Cellule.creer(1, true)
# c6  = Cellule.creer(1, true)
# c7  = Cellule.creer(1, true)
# c8  = Cellule.creer(1, true)
# c9  = Cellule.creer(1, true)
# c10 = Cellule.creer(1, true)
# c11 = Cellule.creer(2, true)
# c12 = Cellule.creer(2, true)
# c13 = Cellule.creer(2, true)
# c14 = Cellule.creer(2, true)
# c15 = Cellule.creer(2, true)
# c16 = Cellule.creer(2, true)
# c17 = Cellule.creer(2, true)
# c18 = Cellule.creer(2, true)
# c19 = Cellule.creer(2, true)
# c20 = Cellule.creer(2, true)
#
# g1 = Grille.creer(10,1)
#
# g1.ajouterCellule(c1,0,0);
# g1.ajouterCellule(c2,1,0);
# g1.ajouterCellule(c3,2,0);
# g1.ajouterCellule(c4,3,0);
# g1.ajouterCellule(c5,4,0);
# g1.ajouterCellule(c6,5,0);
# g1.ajouterCellule(c7,6,0);
# g1.ajouterCellule(c8,7,0);
# g1.ajouterCellule(c9,8,0);
# g1.ajouterCellule(c10,9,0);
#
# gi1 = GroupeIndice.creer(g1.getColonne(0))
# puts gi1
#
# # Que des noirs
#
# g2 = Grille.creer(10,1)
#
# g2.ajouterCellule(c11,0,0);
# g2.ajouterCellule(c12,1,0);
# g2.ajouterCellule(c13,2,0);
# g2.ajouterCellule(c14,3,0);
# g2.ajouterCellule(c15,4,0);
# g2.ajouterCellule(c16,5,0);
# g2.ajouterCellule(c17,6,0);
# g2.ajouterCellule(c18,7,0);
# g2.ajouterCellule(c19,8,0);
# g2.ajouterCellule(c20,9,0);
#
# gi2 = GroupeIndice.creer(g2.getColonne(0))
# puts gi2
# # Commence par une blanche
#
# g7 = Grille.creer(10,1)
#
# g7.ajouterCellule(c1,0,0);
# g7.ajouterCellule(c12,1,0);
# g7.ajouterCellule(c13,2,0);
# g7.ajouterCellule(c14,3,0);
# g7.ajouterCellule(c15,4,0);
# g7.ajouterCellule(c2,5,0);
# g7.ajouterCellule(c17,6,0);
# g7.ajouterCellule(c18,7,0);
# g7.ajouterCellule(c19,8,0);
# g7.ajouterCellule(c20,9,0);
#
# gi7 = GroupeIndice.creer(g7.getColonne(0))
# puts gi7
#
# # Commence par une noire
#
# g3 = Grille.creer(11,1)
#
# g3.ajouterCellule(c11,0,0);
# g3.ajouterCellule(c1,1,0);
# g3.ajouterCellule(c12,2,0);
# g3.ajouterCellule(c2,3,0);
# g3.ajouterCellule(c13,4,0);
# g3.ajouterCellule(c3,5,0);
# g3.ajouterCellule(c14,6,0);
# g3.ajouterCellule(c4,7,0);
# g3.ajouterCellule(c15,8,0);
# g3.ajouterCellule(c5,9,0);
# g3.ajouterCellule(c16,10,0);
#
# gi3 = GroupeIndice.creer(g3.getColonne(0))
# puts gi3
# # Plus d'un espace entre 2 séries de noires
#
# g4 = Grille.creer(8,1)
#
# g4.ajouterCellule(c11,0,0);
# g4.ajouterCellule(c1,1,0);
# g4.ajouterCellule(c12,2,0);
# g4.ajouterCellule(c2,3,0);
# g4.ajouterCellule(c3,4,0);
# g4.ajouterCellule(c14,5,0);
# g4.ajouterCellule(c4,6,0);
# g4.ajouterCellule(c15,7,0);
#
# gi4 = GroupeIndice.creer(g4.getColonne(0))
# puts gi4
