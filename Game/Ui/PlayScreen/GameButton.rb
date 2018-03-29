require "gtk3"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"

class GameButton
  @img
  @gtkObject
  @assets

  attr_reader :gtkObject

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
