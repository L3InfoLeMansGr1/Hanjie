class AProposUi

	attr_reader :gtkObject

	def initialize(parent)
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		@gtkObject = Gtk::Box.new :vertical

		@image = Gtk::Image.new(file:File.dirname(__FILE__) + "/aPropos.png")

		@gtkObject.pack_start(@image, :expand => true, :fill => true, :padding => 0)


		boxButtons = Gtk::ButtonBox.new :horizontal
		boxButtons.layout = :center

		assets = MenuAssets.getInstance()


		buttonBack = MenuItemUi.new(:back,assets)
		buttonBack.setOnClickEvent(Proc.new{
			parent.display(parent.mainMenu)
		})

		boxButtons.add(buttonBack.gtkObject)

		@gtkObject.pack_end(boxButtons,:expand => true, :fill => true, :padding => 0)
		@gtkObject.show_all

	end

end
