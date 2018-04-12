require "gtk3"
require File.dirname(__FILE__) + "/GameButton"
#require File.dirname(__FILE__) + "/../../../"
require File.dirname(__FILE__) + "/Terminal"
require File.dirname(__FILE__) + "/ChronoUi"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"
require File.dirname(__FILE__) + "/../../Core/Moves"
require File.dirname(__FILE__) + "/../../../Main/MenuUi"


#Represents the game menu
class PlayScreen
	@gtkObject										#The table containing everything in this menu
	@controlPanel									#The table containing all game buttons and help buttons
	@chrono												#A chrono object
	@gridBox											#A Gtk::EventBox containing the GridUi object
	@grid													#A Grid object
	@gridUi												#A GridUi object representing the above mentioned Grid object
	@pauseBox											#The table containing the pause menu
	@pauseMenu										#The ButonBox containing the different options available when the gmae is paused (resume, go back to the main menu, quit the game)
	@pauseBackground							#The background image of the pause menu, to be displayed in stread of the grid

	attr_reader :gtkObject

	##
	# * *Arguments* :
	#   - +grid+ -> a GridUi Object
	#   - +accueil+ -> an AccueilUi Object, needed to be able to go back to the main menu without having to cose the game
	def initialize(grid, accueil)
		grid.updateAll
		@accueil = accueil
		@assets = MenuAssets.getInstance
		@grid = grid.gtkObject
		@gridUi = grid
		@gridBox = Gtk::EventBox.new
		@gridBox.add(@grid)
		@gtkObject = Gtk::Table.new(1,3)
		# CONTROL PANEL
		@controlPanel = Gtk::Table.new(11,11)
		# CHRONO BUTTON
		@chrono = ChronoUi.new(grid.game.timer,self)

		# PAUSE MENU

		@pauseBox = Gtk::Table.new(1,1) # contains the pause Menu
		@pauseBackground = Gtk::Image.new(file:File.dirname(__FILE__) + "/../../../Assets/"+@assets.resolution+"/"+@assets.language+"/Menus/Pause.png")


		@pauseMenu = Gtk::ButtonBox.new(:vertical)
		@pauseMenu.layout = :center

		menu = MenuUI.new([:resume, :mainMenu, :quit], @assets)

		menu.setOnClickEvent(:resume){
			@chrono.chrono.start
			unpause
		}

		menu.setOnClickEvent(:quit){
			Gtk.main_quit
		}
		menu.setOnClickEvent(:mainMenu){
			@accueil.display(@accueil.mainMenu)
			changeBackground("menuPrincipal")
		}


		@pauseMenu.add(menu.gtkObject);

		@pauseBox.attach(@pauseMenu,       0, 1, 0, 1)
		@pauseBox.attach(@pauseBackground, 0, 1, 0, 1)


		# TERMINAL
		term = Terminal.new(@grid)
		# HYPOTHESIS BUTTONS
		newH = GameButton.new("blue"){
			if grid.game.currentGuess.moves.moves != nil
				grid.game.currentGuess.moves.clearRedo
				gm = GuessMove.new(:begin)
				grid.game.save.add(gm,grid.game)
				# grid.game.currentGuess=(grid.game.currentGuess.next)
				grid.updateAll
			end
		}

		cancelH = GameButton.new("red"){
			if grid.game.currentGuess.prev != nil then
				clearHypothesis(grid)
				gm = GuessMove.new(:remove)
				grid.game.save.add(gm,grid.game)
				# cancelHypothesis(grid)
				grid.updateAll
			end
		}

		# HELP BUTTONS
		h1 = GameButton.new("aide1",){
			highlight()
		}
		h2 = GameButton.new("aide2"){
			highlightAndGiveTechniq()
		}
		ud = GameButton.new("undo"){
			cells = grid.game.currentGuess.undo(grid.game)
			grid.update(cells)
		}
		rd = GameButton.new("redo"){
			cells = grid.game.currentGuess.redo(grid.game)
			grid.update(cells)
		}

		cl = GameButton.new("clear"){
			grid.game.save.clear()
			clearGame(grid)
		}

		# CHRONO PLACEMENT
		@controlPanel.attach(Gtk::Label.new("\n\n\n\n\n"), 0, 10, 0, 1)
		@controlPanel.attach(@chrono.gtkObject, 3, 4, 1, 2)

		@controlPanel.attach(Gtk::Label.new("\n\n\n\n\n\n\n"), 0, 10, 2, 6)
		# FIRST ROW / FIRST COL
		@controlPanel.attach(newH.gtkObject,    0, 1, 6, 7)
		@controlPanel.attach(cancelH.gtkObject, 2, 3, 6, 7)

		@controlPanel.attach(Gtk::Label.new("\n\n"), 0, 10, 7, 8)

		# SECOND ROW / FIRST COL
		@controlPanel.attach(ud.gtkObject, 0, 1, 8, 9)
		@controlPanel.attach(rd.gtkObject, 1, 2, 8, 9)
		@controlPanel.attach(cl.gtkObject, 2, 3, 8, 9)

		@controlPanel.attach(Gtk::Label.new("\t\t"), 3, 4, 0, 11)

		# FIRST ROW / SECOND COL
		@controlPanel.attach(h1.gtkObject, 4, 6, 6, 7)
		@controlPanel.attach(h2.gtkObject, 6, 8, 6, 7)

		@controlPanel.attach(Gtk::Label.new("\n"), 4, 8, 8, 9)
		# SECOND ROW / SECOND COL
		# @controlPanel.attach(term.gtkObject,    4, 8, 8, 9)

		@controlPanel.attach(Gtk::Label.new("\t\t"), 10, 11, 0, 11)
		@controlPanel.attach(Gtk::Label.new("\n"), 0, 10, 9, 10)



		@gtkObject.attach(@gridBox,      0, 1, 0, 1)
		@gtkObject.attach(@controlPanel, 1, 2, 0, 1)

	end


	##
	# starts the timer
	def run
		@chrono.start
	end

	##
	# Pauses the game. The grid is hidden and the pause menu is displayed in its stead
	def pause
		@gtkObject.remove(@gridBox)
		@gtkObject.attach(@pauseBox,     0, 1, 0, 1)
		@gtkObject.show_all
	end

	##
	# Resumes the game. The pause menu is hidden and the grid is displayed in its stead
	def unpause
		@gtkObject.remove(@pauseBox)
		@gtkObject.attach(@gridBox,      0, 1, 0, 1)
		@gtkObject.show_all
	end

	##
	# Highlights a row or colmn in the grid
	# and gives a solving technique to the player
	# Using this help increases / decreases the timer by 30 secondes
	def highlightAndGiveTechniq
		tech = highlight()
		if(tech != nil)
			@chrono.chrono.penality(30)
			showTechniq(tech)
		end
	end

	##
	# Undoes every move of the player's current guess
	# * *Arguments* :
	#   - +grid+ -> The GridUi Object reprenseting the current game's grid
	def clearHypothesis(grid)
		0.upto(grid.game.currentGuess.moves.moves.length-1){
			cells = grid.game.currentGuess.undo(grid.game)
		}
	end

	##
	# Cancels the current guess by
	# undoing every move of the player's current guess (unsing the clearHypothesis method)
	# also, affects the last guess as the current guess
	# * *Arguments* :
	#   - +grid+ -> The GridUi Object representing the current game's grid
	def cancelHypothesis(grid)
		clearHypothesis(grid)
		grid.game.currentGuess=grid.game.currentGuess.prev
	end

	##
	# Cancels every guess and clears the grid
	# effectively going back to the beginning of the game
	def clearGame(grid)
		while(grid.game.currentGuess.prev != nil) do
			cancelHypothesis(grid)
		end
		clearHypothesis(grid)
		grid.game.currentGuess.moves.clearRedo
		grid.updateAll
	end

	##
	# Shows a solving technique
	# * *Arguments* :
	#   - +tech+ -> the name of the technique to be displayed
	def showTechniq(tech)
		if tech == "intersection"
			text = "<span size=\"large\"><b>La technique des intersections:</b></span> \n Cette technique sert à trouver des cases à noircir.
			Pour chaque bloc de la ligne ou la colonne, le placer à sa position la plus à gauche
			puis faire de même avec la position la plus à droite.
			Toute les cases noircie dans les deux sens le sont réellement."
		elsif tech == "gaps"
			text = "<span size=\"large\"><b>La technique des espaces:</b></span> \n Cette technique sert à trouver des cases où il faut mettre une croix.
			Il y a trois moyens de détecter des espaces:
			- Sur la ligne ou la colonne, un bloc complet est placé contre un bord, vous pouvez donc mettre une croix à l'extrémité
			qui n'est pas celle contre le bord.
			- Sur la ligne ou la colonne, placer le premier bloc à sa position la plus à gauche, toutes les cases à gauche de ce bloc sont des croix.
			Placer le dernier bloc à sa postion la plus à droite, toutes les cases à droite de ce bloc sont des croix.
			- Sur la ligne ou la colonne, un bloc est complet, vous pouvez mettre une croix à gauche et à droite du bloc."
		elsif tech == "minmax"
			text = "<span size=\"large\"><b>La technique des minmaxs</b></span>
			Sur la ligne ou la colonne, un bloc est complet, vous pouvez mettre une croix à gauche et à droite du bloc."
		else

		end
		dialog = Gtk::Dialog.new(
			"Explication technique",
			$main_application_window,
			Gtk::DialogFlags::DESTROY_WITH_PARENT,
			[ Gtk::Stock::OK, Gtk::ResponseType::NONE ]
		)

		# dialog = Gtk::Dialog.new(
		# 	title:"Explication technique",
		# 	parent: $main_application_window,
		# 	flags: Gtk::DialogFlags::DESTROY_WITH_PARENT,
		# 	buttons: [ Gtk::Stock::OK, Gtk::ResponseType::NONE ]
		# )
		label = Gtk::Label.new()
		label.set_use_markup(true)
		label.set_markup(text)
		dialog.child.add(label)
		dialog.signal_connect('response') { dialog.destroy }
		dialog.show_all
	end

	##
	# Highlights a row or column where a cell can be checked or crossed
	def highlight
		nrow = @gridUi.game.nRow
		ncol = @gridUi.game.nCol
		trouve = false
		indFound = -1
		isRow = true
		tech =""
		# p @gridCore.game
		0.upto(nrow-1) do |ind|
			row =  @gridUi.game.getSolverRow(ind)
			if(!row.solved? && row.solvable?)# p row

				if(row.solver_intersections.size > 0)
					puts "intersection trouvée sur la ligne"+ind.to_s
					trouve = true
					indFound = ind
					tech = "intersection"
					break;
				end
				if(row.solver_gaps.size > 0)
					puts "gaps trouvée sur la ligne"+ind.to_s
					trouve = true
					indFound = ind
					tech = "gaps"
					break;
				end
				if(row.solver_minMaxPossibleSize.size > 0)
					puts "minmax trouvée sur la ligne"+ind.to_s
					trouve = true
					indFound = ind
					tech = "minmax"
					break;
				end
				if(row.solver_littleGapsInRange.size > 0)
					puts "little gaps trouvée sur la ligne"+ind.to_s
					trouve = true
					indFound = ind
					tech = "littleGaps"
					break;
				end
			end
		end
		if !trouve
			isRow=false
			0.upto(ncol-1) do |ind|
				col =  @gridUi.game.getSolverCol(ind)
				if(!col.solved? && col.solvable?)
					if(col.solver_intersections.size > 0)
						puts "intersection trouvée sur la colonne"+ind.to_s
						indFound = ind
						trouve = true
						tech = "intersection"
						break;
					end
					if(col.solver_gaps.size > 0)
						puts "gaps trouvée sur la colonne"+ind.to_s
						indFound = ind
						trouve = true
						tech = "gaps"
						break;
					end
					if(col.solver_minMaxPossibleSize.size > 0)
						puts "minmax trouvée sur la colonne"+ind.to_s
						indFound = ind
						trouve = true
						tech = "minmax"
						break;
					end
					if(col.solver_littleGapsInRange.size > 0)
						puts "little gaps trouvée sur la colonne"+ind.to_s
						indFound = ind
						trouve = true
						tech = "littleGaps"
						break;
					end
				end
			end
		end
		if(trouve)
			@chrono.chrono.penality(15)
			# p  @gridUi.colAt(indFound)
			if isRow
				cells = @gridUi.rowAt(indFound)
			else
				cells = @gridUi.colAt(indFound)
			end
			SelectionUi.getInstance().update( cells )
			return tech
		else
			return nil
		end
	end

	##
	# Calls the @accueil object's changeBackground method
	# * *Arguments* :
	#   - +image+ -> The name of the image to be displayed
	def changeBackground(image)
		@accueil.changeBackground(image)
	end

end
