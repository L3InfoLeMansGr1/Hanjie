require File.dirname(__FILE__) + "/Mode"
require File.dirname(__FILE__) + "/../Generation/Generator"

class TimeTrialMode < Mode

	def initialize(accueilui,path = "", difficulty = :easy, nbGridsEnded = 0, time = 600)
		@currentDificulty = difficulty
		@time = time
		if path == ""
			pic = Generator.get(difficulty)
			super(pic,"TimeTrial")
			@nbGridsEnded = nbGridsEnded
			@game.save.setNbGrids(nbGridsEnded)
		else
			super(nil,"","",path)
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

	def initFromPic(pic,mode,level)
		# @time = 600
		@countdown = 1
		super(pic, mode, level)
	end

	def initFromSave(path)
		@countdown = 1
		super(path)
	end

end
