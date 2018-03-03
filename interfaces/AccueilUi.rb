require "gtk3"
require "./interfaces/MenuUi"
require "./interfaces/MenuAssets"
require "./Classement/ClassementUi"
require "./sauvegardes/SauvegardeUi"
require "./interfaces/RankedMode"

class AccueilUi

	@gtkObject
	@currentObject
	@mainMenu
	@gameModesMenu
	@levelsMenu
	@assets
	@mainGrid
	@image

	attr_reader :mainMenu

	def initialize
		@gtkObject = Gtk::Window.new
		@assets = MenuAssets.getInstance()
		initMenus
		initGtkWindow
	end

	def initGtkWindow
		@gtkObject.title = "Hanjie"
		@gtkObject.signal_connect('delete_event') {
			Gtk.main_quit
			false
		}
		@image = Gtk::Image.new(file:"./interfaces/IHM/1440x810/FR_fr/Menus/menuPrincipal.png")
		@mainGrid = Gtk::Table.new(1,1)
		@currentObject = @mainMenu
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@image,0,1,0,1)
		@gtkObject.add(@mainGrid)
		@gtkObject.show_all
	end

	def initMenus
		initMainMenu
		initGameModesMenu
		initlevelsMenu
	end

	def initMainMenu
		menuUi = MenuUI.new([:newGame,:loadGame,:options,:ranking,:about,:quit], @assets)
		menuUi.setOnClickEvent(:newGame){
			display(@gameModesMenu)
		}

		menuUi.setOnClickEvent(:loadGame){
			display(SauvegardeUi.new(self))
		}
    #
		# menuUi.setOnClickEvent(:options){
		# }
    #
		menuUi.setOnClickEvent(:ranking){
			display(ClassementUi.new)
		}
    #
		# menuUi.setOnClickEvent(:about){
		# }
    #
		menuUi.setOnClickEvent(:quit){
			Gtk.main_quit
		}

		@mainMenu =  menuUi
	end

	def initGameModesMenu
		menuUi = MenuUI.new([:aventure,:timetrial,:ranked, :tutorial, :back], @assets)
		menuUi.setOnClickEvent(:aventure){
			#display(AventureMode.new)
		}

		menuUi.setOnClickEvent(:timetrial){
			#display(TimeTrialMode.new)
		}

		menuUi.setOnClickEvent(:ranked){
			display(@levelsMenu)
		}

		menuUi.setOnClickEvent(:tutorial){
			#display(TutorialMode.new)
		}

		menuUi.setOnClickEvent(:back){
			display(@mainMenu)
		}
		@gameModesMenu = menuUi
	end

	def initlevelsMenu
		menuUi = MenuUI.new([:easy,:intermediate,:hard, :back], @assets)
		menuUi.setOnClickEvent(:easy){
			display(RankedMode.new(:easy))
		}

		menuUi.setOnClickEvent(:intermediate){
			display(RankedMode.new(:intermediate))
		}

		menuUi.setOnClickEvent(:hard){
			display(RankedMode.new(:hard))
		}

		menuUi.setOnClickEvent(:back){
			display(@gameModesMenu)
		}
		@levelsMenu = menuUi
	end


	def start
		Gtk.main
	end

	#thing must have an readable attribute gtkObject of type gtk::Box
	def display(thing)
		@mainGrid.remove(@currentObject.gtkObject)
		@mainGrid.remove(@image)
		@currentObject = thing
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@image,0,1,0,1)
		show_all
	end

	def show_all
		@gtkObject.show_all
	end

end
