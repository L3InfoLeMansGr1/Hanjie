require 'yaml'
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

	def to_s
		return @score_joueur["nom"] +  (@score_joueur["score"]).to_s
	end


end # Marqueur de fin de classe
