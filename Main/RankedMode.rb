require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"
require File.dirname(__FILE__) + "/../Classement/Classement_gen"
require File.dirname(__FILE__) + "/../Classement/Joueur_score"

##
# Representation of the RankedMode object
class RankedMode < Mode

	##
	# Creates a new RankedMode
	# If path param is set, load the corresponding Ranked Game
	# else creates a new one
	# * *Arguments* :
	#   - +difficulty+     -> Grid level (one in [:easy, :intermediate, :hard])
	#   - +accueilui+     -> graphic parent to back on when the game is won
	#   - +path+     -> path to the save if it's a reload, empty string if it's a new Game
	def initialize(difficulty, accueilui, path = "")
		if path == ""
			pic = Generator.get(difficulty)
			super(accueil, pic,"Ranked",difficulty)
		else
			super(accueil, nil,"","",path)
		end
		@game.addWinObservator(Proc.new{
			classement = Classement_gen.instance()

			if(classement.ajoutable?(Joueur_score.new("",50,"Classé")))
				dialog = Gtk::Dialog.new("Sauvegarde",
                             $main_application_window,
                             Gtk::DialogFlags::MODAL | Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::YES, Gtk::ResponseType::ACCEPT ],
													 	 [ Gtk::Stock::NO, Gtk::ResponseType::REJECT ])

    		dialog.child.add(Gtk::Label.new( "\nVoulez-vous Sauvegarder votre score?\n" ))
				pseudo = Gtk::Entry.new()
				dialog.child.add(pseudo)

				dialog.show_all

				dialog.signal_connect('response') { |dial,rep|
					#Si oui
					if rep == -3
						mode =""
						puts @game.save.level
						if(@game.save.level == "easy")
							mode = "Mode Facile"
						elsif (@game.save.level == "intermediate")
							mode = "Mode Moyen"
						else
							mode = "Mode Difficile"
						end
						classement.ajouteJoueur(Joueur_score.new(pseudo.text, 2400-@game.timer.sec, mode))
					end
					dialog.destroy
					accueilui.changeBackground("menuPrincipal")
					accueilui.display(accueilui.mainMenu)
					@game.save.delete
				}
			end
		})
	end

	def initFromPic(pic,mode,level, accueil)
		@time = 0
		@countdown = 0
		super(pic, mode, level, accueil)
	end

	def initFromSave(path, accueil)
		@countdown = 0
		super(path, accueil)
	end

end
