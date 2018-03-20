# require "gtk3"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"

class TerminalInput
  @gtkObject
  @text
  @assets
  @name

  attr_reader :gtkObject

  def initialize(name)
    @name = name
    @assets = MenuAssets.getInstance
    @text = Gtk::Label.new(">"+name)
    @gtkObject = Gtk::EventBox.new
    @gtkObject.add(@text)
  end

  def hide
    @text.set_text("")
  end

  def show
    @text.set_text(">"+@name)
  end
end
