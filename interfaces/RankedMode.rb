require "./interfaces/Mode"
require "./Generation/Generator"

class RankedMode < Mode

	def initialize(difficulty)
		pic = Generator.get(difficulty)
		super(pic)
	end

	def onWin
		#Verifier si le score est a ajouter ou pas, si oui demander a l'utilisateur d'entrer son nom
		#et ajouter le score
	end

end
