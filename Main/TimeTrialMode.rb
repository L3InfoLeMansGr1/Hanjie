require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"

class TimeTrialMode < Mode

	def initialize(accueilui,path = "")
		if path == ""
			pic = Generator.get(:easy)
			super(pic,"TimeTrial")
		else
			super(nil,"","",path)
		end
		@game.addWinObservator(Proc.new{

		})
	end

	def onWin
		#Verifier si le score est a ajouter ou pas, si oui demander a l'utilisateur d'entrer son nom
		#et ajouter le score
	end

	def initFromPic(pic,mode,level)
		@time = 600
		@countdown = 1
		super(pic, mode, level)
	end

	def initFromSave(path)
		@countdown = 1
		super(path)
	end

end
