class TutorialMode

	attr_reader :gtkObject

	def initialize(parent)
		@currentPage = 0
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		@gtkObject = Gtk::Box.new :vertical

		@tutorialPages = []
		@tutorialPages.push(Gtk::Image.new(file:File.dirname(__FILE__) + "/Regles.png"))
		@tutorialPages.push(Gtk::Image.new(file:File.dirname(__FILE__) + "/Grille.png"))
		@tutorialPages.push(Gtk::Image.new(file:File.dirname(__FILE__) + "/Gestion_de_la_partie.png"))

		@gtkObject.pack_start(@tutorialPages[@currentPage], :expand => true, :fill => true, :padding => 0)


		boxButtons = Gtk::ButtonBox.new :horizontal
		boxButtons.layout = :center

		buttonPrec = Gtk::EventBox.new
		buttonPrec.signal_connect("button_press_event"){
			puts @currentPage
			if(@currentPage > 0 )
				@gtkObject.remove(@tutorialPages[@currentPage])
				@currentPage -=1
				@gtkObject.pack_start(@tutorialPages[@currentPage], :expand => true, :fill => true, :padding => 0)
				@gtkObject.show_all
			end
		}
		buttonPrec.add(Gtk::Button.new("Précedent"))  # Gtk::Label.new("Précedent"))

		buttonNext = Gtk::EventBox.new
		buttonNext.signal_connect("button_press_event"){
			puts @currentPage
			if(@currentPage < @tutorialPages.size-1 )
				@gtkObject.remove(@tutorialPages[@currentPage])
				@currentPage +=1
				@gtkObject.pack_start(@tutorialPages[@currentPage], :expand => true, :fill => true, :padding => 0)
				@gtkObject.show_all
			end
		}
		buttonNext.add(Gtk::Button.new("Suivant"))

		assets = MenuAssets.getInstance()

		buttonBack = MenuItemUi.new(:back,assets)
		buttonBack.setOnClickEvent(Proc.new{
			parent.display(parent.mainMenu)
		})

		boxButtons.add(buttonPrec)
		boxButtons.add(buttonNext)
		boxButtons.add(buttonBack.gtkObject)

		@gtkObject.pack_end(boxButtons,:expand => true, :fill => true, :padding => 0)
		@gtkObject.show_all

	end

end
