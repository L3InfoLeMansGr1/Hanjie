require 'yaml'
require File.dirname(__FILE__) + "/Joueur_score"
class Classement_gen
        @@instance = Classement_gen.new
	private_class_method :new

	def self.instance
	    return @@instance
	end

	##
	# Extract the Joueur_score from the file output.yml. 
	# * *Returns* :
	#   -The array of Joueur_score.
	def deserealiseJoueurs()
		tab = Array.new
		parsed = begin
  		tab = YAML.load(File.open("./Classement/output.yml"))
		rescue ArgumentError => e
  			puts "Could not parse YAML: #{e.message}"
		end
		if(tab)
			return tab if tab.size <= 1
			swapped = true
			while swapped do
				swapped = false
				0.upto(tab.size-2) do |i|
					if tab[i].donneScore < tab[i+1].donneScore
						tab[i], tab[i+1] = tab[i+1], tab[i]
						swapped = true
					end
				end
			end
		  	tab
		end
	end

	##
	# Check if the player id the 10 bests.
	# * *Arguments* :
	#   - +unJoueur+ -> a Joueur_score object.
	# * *Returns* :
	#   -Boolean, true if the player is the 10 bests.

	def ajoutable?(unJoueur)
		res = Array.new
		tab = deserealiseJoueurs
		if(tab != nil)
			unMode = unJoueur.donneMode
			tab.each do |joueur|
				if joueur.donneMode == unMode
					res.push(joueur)
				end

			end

			if res.size < 10
				return true
			else
				if  res[res.size-1].donneScore < unJoueur.donneScore
					return true
				else
					return false
				end
			end
		else
			return true
		end

	end


	##
	# Replace the last Joueur_score if the Joueur_score in the parameters is 10 in the mode.
	# * *Arguments* :
	#   - +unJoueur+ -> a Joueur_score object.
	# * *Returns* :
	#   -Boolean, true if the player is the 10 bests.
	def remplaceDernier(tab, unJoueur)
		res = Array.new
		# res.push(tab)
		if(tab != nil)
			tab.each do |joueur|
				if joueur.donneMode == unJoueur.donneMode
					res.push(joueur)
				end

			end
			if(res.size < 10)
				tab.push(unJoueur)
			else
			  	tab[tab.index(res[res.size-1])] = unJoueur
			end
		else
			tab.push(unJoueur)
		end

		return tab
	end



	##
	# Add the Joueur_score in parameter to the classement.
	# * *Arguments* :
	#   - +unJoueur+ -> a Joueur_score object.
	def ajouteJoueur(unJoueur)
		tab = deserealiseJoueurs
		puts tab
		if ajoutable?(unJoueur)
			tab = remplaceDernier(tab, unJoueur)
			puts tab
			File.open("./Classement/output.yml", "w") {|f| f.write(tab.to_yaml) }
		end
	end

end
