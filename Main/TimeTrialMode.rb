require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"


##
# Representation of the TimeTrialMode object
class TimeTrialMode < Mode


	##
	# Creates a new TimeTrialMode object
	# If path param is set, load the corresponding TimeTrial Game
	# else creates a new one
	# * *Arguments* :
	#   - +accueilui+     -> graphic parent to back on when the game is won
	#   - +path+     -> path to the save if it's a reload, empty string if it's a new Game
	#   - +difficulty+     -> #Grid level (one in [:easy, :intermediate, :hard])
	#   - +nbGridsEnded+     -> #number of won grids
	#   - +time+     -> #time to set Chronometre with
	def initialize(accueilui,path = "", difficulty = :easy, nbGridsEnded = 0, time = 600)
		@currentDificulty = difficulty
		@time = time
		if path == ""
			pic = Generator.get(difficulty)
			super(accueilui, pic,"TimeTrial")
			@nbGridsEnded = nbGridsEnded
			@game.save.setNbGrids(nbGridsEnded)
		else
			super(accueilui, nil,"","",path)
			@nbGridsEnded = @game.save.nbGames
		end
		@game.addWinObservator(Proc.new{
			# @nbGridsEnded += 1
			@game.save.delete
			difficulty = :easy
			if @nbGridsEnded > 5
				difficulty = :intermediate
			elsif @nbGridsEnded > 10
				difficulty = :hard
			end
			accueilui.display(TimeTrialMode.new(accueilui,"",difficulty, @nbGridsEnded+1,@chrono.add_seconds(600)))
		})

		@chrono.addNoMoreTimeObs(Proc.new{
			dialog = Gtk::Dialog.new("Plus de temps",
                             $main_application_window,
                             Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

    	dialog.signal_connect('response') {
				accueilui.changeBackground("menuPrincipal")
				accueilui.display(accueilui.mainMenu)
				@game.save.delete
				dialog.destroy
			}
			dialog.child.add(Gtk::Label.new("Vous n'avez plus de temps, vous avez complété #{@nbGridsEnded} grilles, bien joué !
Vous allez être rediriger vers le menu principal."))
			dialog.show_all
		})
	end

	def initFromPic(pic,mode,level, accueil)
		# @time = 600
		@countdown = 1
		super(pic, mode, level, accueil)
	end

	def initFromSave(path, accueil)
		@countdown = 1
		super(path, accueil)
	end

end
