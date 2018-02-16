# Cette classe représente une case de la grille de picross
# chaque cellule est définie par son état (blanche/noicie ou barrée)
# @see Constants.rb
# Il est impossible de colorier en noir une case barrée comme il est impossible de barrer une case noircie
# L'état d'une cellule change (ou pas) selon le clic qu'on fait dessus (voir méthodes clicDroit et clicGauche)

#include Comparable
load '../Constants.rb'

class Cellule

	# @etat         L'état de la cellule, NOIR, BLANC ou CROIX
	# @droit        Le droit de la cellule, Marvin m'a dit qu'il s'en servirait peut être un jour alors je le laisse

	attr_accessor :etat, :droit
	private_class_method :new

	# Initialise une nouvelle instance de la classe cellule avec son etat et son clicDroit
	# @param etat : l'état de initial de la grille blanc par défaut pour une nouvelle grille, variable pour une partie chargée
	# @param droit :
	def initialize(etat, droit)
		@etat = etat
		@droit = droit
	end

	# Crée une nouvelel instance de la classe cellule, on préfère rendre la méthode new privée
	# du fait des paramètres utilisés lors de l'instanciation d'une cellule
	def Cellule.creer(etat, droit)
		new(etat, droit)
	end

	# Change l'état d'une cellule selon son état initial lors d'un clic
	# le clic droit est associé à l'ajout et au retrait d'une croix sur une case blanche par conséquent
	# Si l'état de la case est BLANC, on le passe à CROIX
	# Si l'état de la case est NOIR, on le laisse à NOIR, il n'est pas possible de poser une croix sur une case noire, il faut la repsser en blanc d'abord
	# Si l'état de la case est CROIX, on le passe à BLANC
	def clicDroit()
		if(@etat == BLANC)
			@etat = CROIX
		elsif(@etat == NOIR)
			@etat = NOIR
		else
			@etat = BLANC
		end
		return @etat
	end #Method clicDroit

	# Change l'état d'une cellule selon son état initial lors d'un clic gauche
	# Le clic gauche est associé à la transformation d'une case blanche en une case noire (et vice versa) par conséquent
	# Si l'état de la case est BLANC, on le passe à NOIR
	# Si l'état de la case est NOIR, on le passe à BLANC
	# Si l'état de la case est CROIX, on le laisse à CROIX, il n'esyt pas possible de poser une croix sur une case noire, il faut la repasser en blanc d'abord
	def clicGauche()
		if(@etat == BLANC)
			@etat = NOIR
		elsif(@etat == NOIR)
			@etat = BLANC
		else
			@etat = CROIX
		end
		return @etat
	end #Method clicGauche

	# Permet de générer dans la cellule qui reçoit le message une copie de la cellule passée en paramètre
	# Méthode utilisée pour dupliquer la grille
	# @see Grille
	# @param cellule la cellule que l'on veut copier
	def Cellule.copier(cellule)
		return new(cellule.etat,cellule.droit)
	end

	# Affiche uen chaine de caractères contenant l'état et le droit d'une cellule
	# utilisée seulement pour les tests
	def to_s
		return "etat = #{@etat}, droit =  #{@droit}"
	end

	# Remet une case à son état par défaut (BLANC)
	def reset
		@etat = 1
	end

	# Permet de comparer deux cellules et de vérifier si elles ont le même état
	# /!\ Deux cellules sont égales si l'état des deux est NOIR ou si l'état d'aucune des deux ne l'est
	# Une cellule à l'état BLANC et une autre à l'état CROIX sont donc ici égales
	# @param autreCellule, la cellule qu'on compare à l'instance qui reçoir le message
	# @return boolean true, si les cellules sont égales
	# @return boolean false, si les cellules ne sont pas égales
	def equals(autreCellule)
		if (@etat == NOIR && autreCellule.etat == NOIR)
			return true
		elsif ( ( @etat == BLANC || @etat == CROIX ) && (autreCellule.etat == BLANC || autreCellule.etat == CROIX) )
			return true
		else
			return false
		end
	end #Method equals

end #Class Cellule
