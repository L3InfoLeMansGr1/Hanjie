require 'yaml'
require File.dirname(__FILE__) + "/Joueur_score"
class Classement_gen



	def initialize()
		@tabJoueurs  = Array.new()
	end


	def bubble_sort
		return @tabJoueurs if @tabJoueurs.size <= 1
		swapped = true
		while swapped do
			swapped = false
			0.upto(@tabJoueurs.size-2) do |i|
				if @tabJoueurs[i].donneScore < @tabJoueurs[i+1].donneScore
					@tabJoueurs[i], @tabJoueurs[i+1] = @tabJoueurs[i+1], @tabJoueurs[i]
					swapped = true
				end
			end
		end
	  	@tabJoueurs
	end




 	def afficheToi
 		print(@tabJoueurs)
 	end



	def deserealiseJoueurs()
		tab2 = Array.new
		parsed = begin
  		tab2 = YAML.load(File.open("./Classement/output.yml"))
		rescue ArgumentError => e
  			puts "Could not parse YAML: #{e.message}"
		end
		return(tab2)
	end


	def getTab()
		return(@tabJoueurs)
	end


	def ajouteJoueur(unJoueur)
		@tabJoueurs.push(unJoueur)
		File.open("output.yml", "w") {|f| f.write(@tabJoueurs.to_yaml) }
	end

end
