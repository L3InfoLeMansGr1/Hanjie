require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"

class RankedMode < Mode

	def initialize(difficulty, path = "")
		if path == ""
			pic = Generator.get(difficulty)
			super(pic,"Ranked",difficulty)
		else
			super(nil,"","",path)
		end
	end

	def initFromPic(pic,mode,level)
		@time = 0
		@countdown = 0
		super(pic, mode, level)
	end

	def initFromSave(path)
		@countdown = 0
		super(path)
	end

	def onWin
		#Verifier si le score est a ajouter ou pas, si oui demander a l'utilisateur d'entrer son nom
		#et ajouter le score
	end

end
