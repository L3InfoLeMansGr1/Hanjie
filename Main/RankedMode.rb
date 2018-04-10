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
				dialog = Gtk::Dialog.new("Sauvegarde?",
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

				}
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
