class TutorialMode

	attr_reader :gtkObject

	def initialize(parent)
		@currentPage = 0
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		@gtkObject = Gtk::Box.new :vertical
		tutorialPage = Gtk::Image.new(file:File.dirname(__FILE__) + "/Règles.png")
		@gtkObject.pack_start(tutorialPage, :expand => true, :fill => true, :padding => 0)
		@gtkObject.show_all
	end

end
