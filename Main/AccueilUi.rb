require "gtk3"
require "./Main/MenuUi"
require "./Main/MenuAssets"
require "./Classement/ClassementUi"
require "./Sauvegardes/SauvegardeUi"
require "./Main/RankedMode"
require "./Main/OptionsUi"

class AccueilUi

	@gtkObject
	@currentObject
	@mainMenu
	@gameModesMenu
	@levelsMenu
	@assets
	@mainGrid
	@background

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
		@gtkObject.set_resizable(false)
		@background = Gtk::Image.new(file:"./Assets/"+@assets.resolution+"/"+@assets.language+"/Menus/menuPrincipal.png")
		@mainGrid = Gtk::Table.new(1,1)
		@currentObject = @mainMenu
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@background,0,1,0,1)
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

		menuUi.setOnClickEvent(:options){
			display(OptionsUi.new(self))
		}

		menuUi.setOnClickEvent(:ranking){
			display(ClassementUi.new(self))
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

	#thing must have a readable attribute gtkObject of type gtk::Box
	def display(thing)
		@mainGrid.remove(@currentObject.gtkObject)
		@mainGrid.remove(@background)
		@currentObject = thing
		@mainGrid.attach(@currentObject.gtkObject, 0, 1, 0,1)
		@mainGrid.attach(@background,0,1,0,1)
		show_all
	end

	def show_all
		@gtkObject.show_all
	end

	def changeBackground(image)
		@mainGrid.remove(@background)
		@background = Gtk::Image.new(file:"./Assets/"+@assets.resolution+"/"+@assets.language+"/Menus/"+image+".png")
		@mainGrid.attach(@background,0,1,0,1)
		show_all
	end
end
