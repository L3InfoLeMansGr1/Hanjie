require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"
require File.dirname(__FILE__) + "/../Classement/Classement_gen"
require File.dirname(__FILE__) + "/../Classement/Joueur_score"

class RankedMode < Mode

	def initialize(difficulty, path = "")
		if path == ""
			pic = Generator.get(difficulty)
			super(pic,"Ranked",difficulty)
		else
			super(nil,"","",path)
		end
		@game.addWinObservator(Proc.new{
			classement = Classement_gen.instance()
			if(classement.ajoutable?(Joueur_score.new("",50,"Classé")))
				classement.ajouteJoueur(Joueur_score.new("",50,"Classé"))
			end
		})
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

end
