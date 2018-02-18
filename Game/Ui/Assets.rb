require File.dirname(__FILE__) + "/Asset"

class Assets

	WHITE = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blancGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blancGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blancGrille20x20.png"
	}
	BLACK = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noirGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noirGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noirGrille20x20.png"
	}

	CROSS = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croixGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croixGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croixGrille20x20.png"
	}

	WHITE_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blanc_selectGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blanc_selectGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/blanc_selectGrille20x20.png"
	}
	BLACK_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noir_selectGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noir_selectGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/noir_selectGrille20x20.png"
	}

	CROSS_SELECTED = {
		10 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croix_selectGrille10x10.png",
		15 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croix_selectGrille15x15.png",
		20 => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/fr/fonds/croix_selectGrille20x20.png"
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
