require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"

class TimeTrialMode < Mode

	def initialize( path = "")
		if path == ""
			pic = Generator.get(:easy)
			super(pic,"TimeTrial")
		else
			super(nil,"","",path)
		end
	end

	def onWin
		#Verifier si le score est a ajouter ou pas, si oui demander a l'utilisateur d'entrer son nom
		#et ajouter le score
	end

end
