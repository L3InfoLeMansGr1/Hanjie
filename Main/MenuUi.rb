require "gtk3"
require File.dirname(__FILE__) + "/MenuItemUi"


##
# Representation a menu
class MenuUI

	@gtkObject  #the box to display
	@items #an Hash containing all MenuItemUi with their names, i.e { :name => MenuItemUi}
	@assets #MenuAssets reference

	attr_reader :gtkObject #the box to display

	##
	# Creates a new MenuUI object
	# * *Arguments* :
	#   - +buttonsName+ -> All the MenuItemUi names
	#   - +assets+ -> MenuAssets reference
	def initialize(buttonsName, assets)
		@assets = assets
		@items = Hash.new
		buttonsName.each do |name|
			@items[name] = MenuItemUi.new(name, assets)
		end
		initGtkObject
	end

	##
	# Sets the "OnClick" event of a MenuItemUi to the given Block
	# * *Arguments* :
	#   - +block+     -> the Block to execute when an "OnClick" event occurs
	def setOnClickEvent(name, &block)
		@items[name].setOnClickEvent(block)
	end

	##
	# Inits the Gtk::ButtonBox by adding all the MenuItemUis
	def initGtkObject
		@gtkObject = Gtk::ButtonBox.new(:vertical)
		@gtkObject.layout = :center
		@items.each_value do |item|
			@gtkObject.add(item.gtkObject)
		end
	end

	##
	#Shows all the MenuItemUis
	def show
		@gtkObject.show_all
	end

	##
	#Hides all the MenuItemUis
	def hide
		@gtkObject.hide
	end

end
