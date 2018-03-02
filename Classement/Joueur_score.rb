##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Sat Feb 17 20:31:22 CET 2018
#


class Joueur_score
	def initialize(unNom,unScore,unMode)
		@score_joueur = {
			"nom" => unNom,
			"score" => unScore,
			"mode" => unMode
		}
	end

	def donneNom
		return @score_joueur["nom"]
	end


	def donneScore
		return @score_joueur["score"]
	end

	def donneMode
		return @score_joueur["mode"]
	end

	
	
end # Marqueur de fin de classe



