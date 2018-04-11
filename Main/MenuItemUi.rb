require "gtk3"


##
# Representation a menu item
class MenuItemUi

	@gtkObject #the box to display
	@name #the item name
	@assets #MenuAssets reference


	attr_reader :gtkObject #the box to display

	##
	# Creates a new MenuItemUi object
	# * *Arguments* :
	#   - +name+     -> button name, i.e symbol corresponding to his Asset in the given MenuAssets
	#   - +assets+ -> MenuAssets reference
	def initialize(name, assets)
		@name = name
		@gtkObject = Gtk::EventBox.new
		@assets = assets
		initGtkEventBox
		initializeHover
	end

	##
	# Inits the Gtk::EventBox
	def initGtkEventBox
		asset = @assets.item_asset(@name)
		applyAsset(asset)
	end

	##
	# Applies the given Asset
	# * *Arguments* :
	#   - +asset+     -> the Asset to apply
	def applyAsset(asset)
		asset.applyOn(@gtkObject)
	end

	##
	# Sets the "OnClick" event to the given Block
	# * *Arguments* :
	#   - +block+     -> the Block to execute when an "OnClick" event occurs
	def setOnClickEvent(block)
		@gtkObject.signal_connect("button_press_event",&block)
	end


	# Inits the item to glow when mouse enters this item and unglow when mouse leaves this item
	private
	def initializeHover()
		@gtkObject.signal_connect("enter_notify_event"){
			applyAsset(@assets.item_asset_selected(@name))
		}

		@gtkObject.signal_connect("leave_notify_event"){
			applyAsset(@assets.item_asset(@name))
		}
	end

end
