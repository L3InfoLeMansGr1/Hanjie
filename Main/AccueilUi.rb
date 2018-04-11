require "gtk3"
require File.dirname(__FILE__) + "/MenuUi"
require File.dirname(__FILE__) + "/MenuAssets"
require File.dirname(__FILE__) + "/../Classement/ClassementUi"
require File.dirname(__FILE__) + "/../Sauvegardes/SauvegardeUi"
require File.dirname(__FILE__) + "/RankedMode"
require File.dirname(__FILE__) + "/TimeTrialMode"
require File.dirname(__FILE__) + "/OptionsUi"
require File.dirname(__FILE__) + "/../Tutorial/TutorialMode"
require File.dirname(__FILE__) + "/../APropos/AProposUi"


#Representation of the main menu
class AccueilUi

	@gtkObject #Main window
	@currentObject #Current displayed Gtk::Box
	@mainMenu #Main menu
	@gameModesMenu #Game modes menu
	@levelsMenu #Levels menu
	@assets #Menu assets
	@mainGrid #Main grid
	@background #background Gtk::Image

	attr_reader :mainMenu #The main menu

	##
	# Creates a new AccueilUi object
	def initialize
		@gtkObject = Gtk::Window.new
		@assets = MenuAssets.getInstance()
		initMenus
		initGtkWindow
	end


	##
	# Inits Main window
	def initGtkWindow
		@gtkObject.title = "Hanjie"
		@gtkObject.signal_connect('delete_event') {
			Gtk.main_quit
			false
		}
		@gtkObject.set_resizable(false)
		@background = Gtk::Image.new(file:File.dirname(__FILE__) + "/../Assets/"+@assets.resolution+"/"+@assets.language+"/Menus/menuPrincipal.png")
		@mainGrid = Gtk::Table.new(1,1)
		@currentObject = @mainMenu
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@background,0,1,0,1)
		@gtkObject.add(@mainGrid)
		@gtkObject.show_all
	end

	##
	# Inits all menus
	def initMenus
		initMainMenu
		initGameModesMenu
		initlevelsMenu
	end


	##
	# Inits main menu
	def initMainMenu
		menuUi = MenuUI.new([:newGame,:loadGame,:options,:ranking,:about, :tutorial,:quit], @assets)
		menuUi.setOnClickEvent(:newGame){
			display(@gameModesMenu)
		}

		menuUi.setOnClickEvent(:loadGame){
			display(SauvegardeUi.new(self))
		}

		menuUi.setOnClickEvent(:options){
			display(OptionsUi.new(self))
		}

		menuUi.setOnClickEvent(:ranking){
			display(ClassementUi.new(self))
		}

		menuUi.setOnClickEvent(:about){
			display(AProposUi.new(self))
		}

		menuUi.setOnClickEvent(:tutorial){
			display(TutorialMode.new(self))
		}

		menuUi.setOnClickEvent(:quit){
			Gtk.main_quit
		}

		@mainMenu =  menuUi
	end

	##
	#Inits game mode menu
	def initGameModesMenu
		menuUi = MenuUI.new([:timetrial,:ranked, :back], @assets)
		menuUi.setOnClickEvent(:aventure){
			#display(AventureMode.new)
		}

		menuUi.setOnClickEvent(:timetrial){
			display(TimeTrialMode.new(self))
			changeBackground("ecranDeJeu")
		}

		menuUi.setOnClickEvent(:ranked){
			display(@levelsMenu)
		}

		menuUi.setOnClickEvent(:back){
			display(@mainMenu)
		}
		@gameModesMenu = menuUi
	end

	##
	#Inits levels menu
	def initlevelsMenu
		menuUi = MenuUI.new([:easy,:intermediate,:hard, :back], @assets)
		menuUi.setOnClickEvent(:easy){
			display(RankedMode.new(:easy,self))
			self.changeBackground("ecranDeJeu")
		}

		menuUi.setOnClickEvent(:intermediate){
			display(RankedMode.new(:intermediate,self))
			self.changeBackground("ecranDeJeu")
		}

		menuUi.setOnClickEvent(:hard){
			display(RankedMode.new(:hard,self))
			self.changeBackground("ecranDeJeu")
		}

		menuUi.setOnClickEvent(:back){
			display(@gameModesMenu)
		}
		@levelsMenu = menuUi
	end

	##
	#Starts main loop
	def start
		Gtk.main
	end

	##
	# Displays on the main window an object who MUST have a readable Gtk::Box attribute
	# * *Arguments* :
	#   - +obj+     -> an object who MUST have a readable Gtk::Box attribute
	def display(obj)
		@mainGrid.remove(@currentObject.gtkObject)
		@mainGrid.remove(@background)
		@currentObject = obj
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@background,0,1,0,1)
		show_all
	end

	##
	#Shows all main window children
	def show_all
		@gtkObject.show_all
	end

	##
	# Updates main window background with the given image
	# * *Arguments* :
	#   - +image+     -> image name to display
	def changeBackground(image)
		@mainGrid.remove(@background)
		@background = Gtk::Image.new(file: File.dirname(__FILE__) + "/../Assets/"+@assets.resolution+"/"+@assets.language+"/Menus/"+image+".png")
		@mainGrid.attach(@background,0,1,0,1)
		show_all
	end
end
