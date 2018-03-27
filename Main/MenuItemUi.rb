require "gtk3"

class MenuItemUi

	@gtkObject
	@name
	@assets

	attr_reader :gtkObject

	def initialize(name, assets)
		@name = name
		@gtkObject = Gtk::EventBox.new
		@assets = assets
		initGtkEventBox
		initializeHover
	end

	def initGtkEventBox
		asset = @assets.item_asset(@name)
		applyAsset(asset)
	end


	def applyAsset(asset)
		asset.applyOn(@gtkObject)
	end

	def setOnClickEvent(block)
		@gtkObject.signal_connect("button_press_event",&block)
	end

	def initializeHover()
		@gtkObject.signal_connect("enter_notify_event"){
			applyAsset(@assets.item_asset_selected(@name))
		}

		@gtkObject.signal_connect("leave_notify_event"){
			applyAsset(@assets.item_asset(@name))
		}
	end

end
