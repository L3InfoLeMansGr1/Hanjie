# encoding: UTF-8

class Sauvegardes

	def initialize(unChemin,typeFichier)
		@type = typeFichier
		@chemin = unChemin
	end

	def chargerRepertoire
		chaine = @chemin + @type
		@listeFichiers =  Dir.glob(chaine)
	end

	def donneNom(unEntier)
		tailleChemin = @chemin.bytesize
		tailleComplete = @listeFichiers[unEntier].bytesize - @type.bytesize
		@listeFichiers[unEntier][tailleChemin ... tailleComplete+1] #on ajoute 1 pour le "*"
	end

	def afficheComplet
		puts @listeFichiers
	end

	def getIndex(uneValeur)
		if uneValeur == nil
  			return nil
  		else
	     	return @listeFichiers.index(uneValeur)
	    end
	end

	def charger(unIndex)
		if unIndex == nil
  			return false
  		else
			puts "Chargement du fichier :" + donneNom(unIndex) #a redefinir
		end
	end


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
