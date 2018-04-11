require "gtk3"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"

# Allows the use of an image as a button by placing it in a Gtk::EventBox
class GameButton
  @img
  @gtkObject
  @assets

  attr_reader :gtkObject

	##
	# * *Arguments* :
	#   - +name+ -> the name of the image to be used as a button
	#   - +block+ -> the actions the button has to do when clicked on
	# * *Returns* :
	#   -a GameButton Object instance
  def initialize(name, &block)
    @assets = MenuAssets.getInstance
    path = File.dirname(__FILE__) + "/../../../Assets/" + @assets.resolution + "/Common/Buttons/"
    @name = name
    @img = Gtk::Image.new(file:path + name +"Off.png")
    @gtkObject = Gtk::EventBox.new
    @gtkObject.add(@img)

    @gtkObject.signal_connect("enter_notify_event") do
      @img.set_file(path + name +"On.png")
    end
    @gtkObject.signal_connect("leave_notify_event") do
      @img.set_file(path + name +"Off.png")
    end
		@gtkObject.signal_connect("button_press_event",&block)

  end

end
