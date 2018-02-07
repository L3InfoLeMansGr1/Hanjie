# Contient un groupe d'indice, affiché au dessus d'une colonne où à côté d'un colonne

#load 'Cellule.rb'
#load 'Grille.rb'

BLANC = 1		#Etat tiré de la classe grille, rend le code plus lisible
NOIR = 2		#Etat tiré de la classe grille, rend le code plus lisible

class GroupeIndice

	#@tabIndice				Contient les indices des cases à colorier
	#@somme					Contient la somme des indices ET la somme somme des expaces ( [2, 2, 2] dans le tabIndice donnerait un 2+1+2+1+2 = 8)

	attr_reader :tabIndice
	attr_reader :somme
	private_class_method :new

	##
	# Prend une ligne ou une colonne de Cellule d'une Grille
	# @see Grille
	# @see Cellule
	#
	def initialize(lc)
		i = 0
		lc.each do { |e|
			if(e.etat == NOIR)
				@tabIndice[i] += 1
				@somme += 1
			elsif(e.etat == BLANC && @tabIndice[i] != nil)
				i += 1
			end
		}
		@somme += @tabIndice.size-1 # Ajout du nombre d'espaces
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
		e.each { |e|
			s += "#{@e} "
		}
		return s
	end

end #Class GroupeIndice

# Tests
# A virer une fois testé

# Que des blanches
c1  = Cellule.creer(1, true)
c2  = Cellule.creer(1, true)
c3  = Cellule.creer(1, true)
c4  = Cellule.creer(1, true)
c5  = Cellule.creer(1, true)
c6  = Cellule.creer(1, true)
c7  = Cellule.creer(1, true)
c8  = Cellule.creer(1, true)
c9  = Cellule.creer(1, true)
c10 = Cellule.creer(1, true)
c11 = Cellule.creer(2, true)
c12 = Cellule.creer(2, true)
c13 = Cellule.creer(2, true)
c14 = Cellule.creer(2, true)
c15 = Cellule.creer(2, true)
c16 = Cellule.creer(2, true)
c17 = Cellule.creer(2, true)
c18 = Cellule.creer(2, true)
c19 = Cellule.creer(2, true)
c20 = Cellule.creer(2, true)

g1 = Grille.creer(10,1)

g1.ajouter(c1);
g1.ajouter(c2);
g1.ajouter(c3);
g1.ajouter(c4);
g1.ajouter(c5);
g1.ajouter(c6);
g1.ajouter(c7);
g1.ajouter(c8);
g1.ajouter(c9);
g1.ajouter(c10);

gi1 = GroupeIndice.new()

# Que des noirs

g2 = Grille.creer(10,1)

g2.ajouter(c11);
g2.ajouter(c12);
g2.ajouter(c13);
g2.ajouter(c14);
g2.ajouter(c15);
g2.ajouter(c16);
g2.ajouter(c17);
g2.ajouter(c18);
g2.ajouter(c19);
g2.ajouter(c20);

# Commence par une blanche

g2 = Grille.creer(10,1)

g2.ajouter(c1);
g2.ajouter(c12);
g2.ajouter(c13);
g2.ajouter(c14);
g2.ajouter(c15);
g2.ajouter(c2);
g2.ajouter(c17);
g2.ajouter(c18);
g2.ajouter(c19);
g2.ajouter(c20);

# Commence par une noire

g3 = Grille.creer(10,1)

g3.ajouter(c11);
g3.ajouter(c1);
g3.ajouter(c12);
g3.ajouter(c2);
g3.ajouter(c13);
g3.ajouter(c3);
g3.ajouter(c14);
g3.ajouter(c4);
g3.ajouter(c15);
g3.ajouter(c5);
g3.ajouter(c16);
g3.ajouter(c6);
g3.ajouter(c17);
g3.ajouter(c7);
g3.ajouter(c18);
g3.ajouter(c8);
g3.ajouter(c19);
g3.ajouter(c9);
g3.ajouter(c20);
g3.ajouter(c10);

# Plus d'un espace entre 2 séries de noires

g4 = Grille.creer(10,1)

g4.ajouter(c11);
g4.ajouter(c1);
g4.ajouter(c12);
g4.ajouter(c2);
g4.ajouter(c3);
g4.ajouter(c14);
g4.ajouter(c4);
g4.ajouter(c15);
g4.ajouter(c5);
g4.ajouter(c6);
g4.ajouter(c7);
g4.ajouter(c18);
g4.ajouter(c8);
g4.ajouter(c19);
g4.ajouter(c9);
g4.ajouter(c20);
g4.ajouter(c10);
