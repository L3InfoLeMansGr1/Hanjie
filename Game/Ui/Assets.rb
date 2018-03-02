require File.dirname(__FILE__) + "/Asset"

class Assets

	WHITE = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/white.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/white.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/white.png"
	}
	BLACK = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/black.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/black.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/black.png"
	}

	CROSS = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/cross.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/cross.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/cross.png"
	}

	WHITE_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/whiteSelect.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/whiteSelect.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/whiteSelect.png"
	}
	BLACK_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/blackSelect.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/blackSelect.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/blackSelect.png"
	}

	CROSS_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/10x10/crossSelect.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/15x15/crossSelect.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/backgrounds/20x20/crossSelect.png"
	}

	@cellAssets
	@cellAssets_selected

	# @buttons ...
	def initialize(size)
		unless [10,15,20].include?(size)
			puts "warning: #{size}x#{size} are not supported"
			size = 10
		end
		@cellAssets = {
			white: Asset.new(Assets::WHITE[size]),
			black: Asset.new(Assets::BLACK[size]),
			cross: Asset.new(Assets::CROSS[size])
		}
		@cellAssets_selected = {
			white: Asset.new(Assets::WHITE_SELECTED[size]),
			black: Asset.new(Assets::BLACK_SELECTED[size]),
			cross: Asset.new(Assets::CROSS_SELECTED[size])
		}
	end

	def cell_asset(state)
		@cellAssets[state]
	end

	def cell_asset_selected(state)
		@cellAssets_selected[state]
	end
end
