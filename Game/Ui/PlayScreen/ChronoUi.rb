
require "gtk3"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"

# Represents the "chrono" object in the UI
class ChronoUi
	@parent
  @assets
  @gtkObject
  @chrono
  @chTable

	attr_reader :gtkObject, :chrono

	##
	# Creates a Gtk::EventBox which displays the time spent / left in the game
	# # * *Arguments* :
	#   - +chrono+ -> the chrono object.
	# 	- +parent+ -> The GtkObject the ChronoUi is attached to. A Playscreen Object
  def initialize(chrono,parent)
		@parent = parent
		@assets = MenuAssets.getInstance
    @chrono = chrono
    @chTable = Gtk::Table.new(4,7)
    img = Gtk::Image.new(file:File.dirname(__FILE__) + "/../../../Assets/" + @assets.resolution + "/Common/Buttons/chronoPause.png")
    @gtkObject = Gtk::EventBox.new
    @gtkObject.signal_connect("button_press_event") do
      if(@chrono.paused?) then
				unpause
      else
				pause
      end
    end

    pathToDigit = File.dirname(__FILE__) + "/../../../Assets/" + @assets.resolution + "/Common/Digits/digi0.png"
    dM = Gtk::Image.new(file:pathToDigit)
    uM = Gtk::Image.new(file:pathToDigit)
    dS = Gtk::Image.new(file:pathToDigit)
    uS = Gtk::Image.new(file:pathToDigit)

		@chTable.attach(dM, 1, 2, 1, 2)
		@chTable.attach(uM, 2, 3, 1, 2)
		@chTable.attach(Gtk::Label.new("    "), 3, 4, 1, 2)
		@chTable.attach(dS, 4, 5, 1, 2)
		@chTable.attach(uS, 5, 6, 1, 2)
		@chTable.attach(img,0,7,0,4)
		@chTable.attach(Gtk::Label.new("             "), 0, 1, 0, 1)
		@chTable.attach(Gtk::Label.new("             "), 6, 7, 0, 1)
		@chTable.attach(Gtk::Label.new("\n"),            0, 6, 3, 4)
		@chTable.attach(Gtk::Label.new("             "), 0, 7, 0, 1)
		@gtkObject.add(@chTable)
		GLib::Timeout.add_seconds(1){
				tab = @chrono.display4Ui
				pathToDigit = File.dirname(__FILE__) + "/../../../Assets/" + @assets.resolution + "/Common/Digits/"
				dM.set_file(pathToDigit+"digi"+tab[0].to_s+".png")
				uM.set_file(pathToDigit+"digi"+tab[1].to_s+".png")
				dS.set_file(pathToDigit+"digi"+tab[2].to_s+".png")
				uS.set_file(pathToDigit+"digi"+tab[3].to_s+".png")
				true
		}
	end

	##
	# restarts the timer
	def unpause
		@chrono.start
		@parent.unpause
	end

	##
	# Stops the timer
	def pause
		parent.pause
		@chrono.stop
	end

	##
	# starts the timer
	def start
		@chrono.start
	end
end
