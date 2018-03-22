require 'yaml'
require File.dirname(__FILE__) + "/Joueur_score"
class Classement_gen
	
        @@instance = Classement_gen.new
	private_class_method :new

	def self.instance
	    return @@instance
	end


	def deserealiseJoueurs()
		tab = Array.new
		parsed = begin
  		tab = YAML.load(File.open("./Classement/output.yml"))
		rescue ArgumentError => e
  			puts "Could not parse YAML: #{e.message}"
		end
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




	def ajoutable?(unJoueur)
		res = Array.new
		tab = deserealiseJoueurs
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
		
	end


	def remplaceDernier(tab, unJoueur)
		res = Array.new
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
		return tab
	end

	def ajouteJoueur(unJoueur)
		tab = deserealiseJoueurs
		if ajoutable?(unJoueur)
			tab = remplaceDernier(tab, unJoueur)
			File.open("./Classement/output.yml", "w") {|f| f.write(tab.to_yaml) }
		end	
	end

end
