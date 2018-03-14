require "gtk3"
require File.dirname(__FILE__) + "/MenuItemUi"

class MenuUI

	@gtkObject
	@items
	@assets

	attr_reader :gtkObject

	def initialize(buttonsName, assets)
		@assets = assets
		@items = Hash.new
		buttonsName.each do |name|
			@items[name] = MenuItemUi.new(name, assets)
		end
		initGtkObject
	end

	def setOnClickEvent(name, &block)
		@items[name].setOnClickEvent(block)
	end

	def initGtkObject
		@gtkObject = Gtk::ButtonBox.new(:vertical)
		@gtkObject.layout = :center
		@items.each_value do |item|
			@gtkObject.add(item.gtkObject)
		end
	end

	def show
		@gtkObject.show_all
	end

	def hide
		@gtkObject.hide
	end

end
