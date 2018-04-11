require 'yaml'
class Joueur_score

	##
	# Creates a new Joueur_score object.
	# * *Arguments* :
	#   - +unNom+ -> The player name.
	#   - +unScore+ -> The score of the game.
	#   - +unMode+ -> The mode of the game.
	def initialize(unNom,unScore,unMode)
		@score_joueur = {
			"nom" => unNom,
			"score" => unScore,
			"mode" => unMode
		}
	end


	##
	# Return the name of the player. 
	# * *Returns* :
	#   -The name of the player.
	def donneNom
		return @score_joueur["nom"]
	end

	##
	# Return the score of the player. 
	# * *Returns* :
	#   -The score of the player.
	def donneScore
		return @score_joueur["score"]
	end


	##
	# Return the game mode. 
	# * *Returns* :
	#   -The game mode.
	def donneMode
		return @score_joueur["mode"]
	end



	##
	# Redefined the to_s methode . 
	# * *Returns* :
	#   -The player infomation into a string.
	def to_s
		return @score_joueur["nom"] +  (@score_joueur["score"]).to_s
	end


end # Marqueur de fin de classe
