# encoding: UTF-8

class Sauvegardes


	##
	# Creates a new Sauvegardes object
	# * *Arguments* :
	#   - +unChemin+ -> The path to the saves
	#   - +typeFichier+ -> The type of the saves files 
	def initialize(unChemin,typeFichier)
		@type = typeFichier
		@chemin = unChemin
	end


	##
	# collect all names of saves files
	def chargerRepertoire
		chaine = @chemin + @type
		@listeFichiers =  Dir.glob(chaine)
	end

	##
	# Return the index of the save file in the array. 
	# * *Arguments* :
	#   - +unIndex+ -> index of the saves in the save list.
	# * *Returns* :
	#   - ++ -> The name of the file.
	def donneNom(unEntier)
		tailleChemin = @chemin.bytesize
		tailleComplete = @listeFichiers[unEntier].bytesize
		@listeFichiers[unEntier][tailleChemin ... tailleComplete+1] #on ajoute 1 pour le "*"
	end


	##
	# Display the saves list
	def afficheComplet
		puts @listeFichiers
	end


	##
	# Return the index of the save file in the array. 
	# * *Arguments* :
	#   - +uneValeur+ -> The save name.
	# * *Returns* :
	#   - ++ -> index of the saves in the save list.

	def getIndex(uneValeur)
		if uneValeur == nil
  			return nil
  		else
	     	return @listeFichiers.index(uneValeur)
	    end
	end


	##
	# get the information of the file name in an array
	# * *Arguments* :
	#   - +unIndex+ -> index of the saves in the save array.
	# * *Returns* :
	#   - ++ -> Array this informations.
	def getInfos(unIndex)
		if unIndex == nil
  		return false
  	else
			path = donneNom(unIndex)
			return path.split("&")
		end
	end

	##
	# Remove a save 
	# * *Arguments* :
	#   - +unIndex+ -> index of the saves in the save array.
	def supprimer(unIndex)
		if unIndex == nil
  			return false
  		else
		 File.delete(@listeFichiers[unIndex])
		 end
	end


end

#save = Sauvegardes.new("/home/thomas/Bureau/Sauvegardes Test/","*.txt")
#save.chargerRepertoire
#save.afficheComplet
#save.getIndex("save4")
