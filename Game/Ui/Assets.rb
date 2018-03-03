require File.dirname(__FILE__) + "/Asset"

class Assets

	LANGUAGE = {
		"fr"  => "FR_fr",
		"en"  => "En_en",
	}

	RESOLUTION = {
		1440 => "1440x810",
		1280 => "1280x720",
		1024 => "1024x576"
	}

	WHITE = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/white.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/white.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/white.png"
	}

	BLACK = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/black.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/black.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/black.png"
	}

	CROSS = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/cross.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/cross.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/cross.png"
	}

	WHITE_SELECTED = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/whiteSelect.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/whiteSelect.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/whiteSelect.png"
	}

	BLACK_SELECTED = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/blackSelect.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/blackSelect.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/blackSelect.png"
	}

	CROSS_SELECTED = {
		"1440FR10" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/10x10/crossSelect.png",
		"1440FR15" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/15x15/crossSelect.png",
		"1440FR20" => File.dirname(__FILE__) + "/../../interfaces/" + "IHM/1440x810/Common/Backgrounds/20x20/crossSelect.png"
	}

	@@assetInstance = nil 				#Singleton
	@cellAssets
	@cellAssets_selected
	# @language 							# Only a single language possible at a time
	# @resolution							# Only a single resolution possible at a time

	# attr_accessor :language
	# attr_accessor :resolution
	private_class_method :new

	#def Assets.getInstance(size, resolution=10, language="FR_fr")
	def Assets.getInstance(size)
		if @@assetInstance == nil then
			#@@assetInstance = new(size, resolution, language)
			@@assetInstance = new(size)
		end
		return @@assetInstance
	end

	# @buttons ...
	#def initialize(size, resolution, language)
	def initialize(size)
		unless [10,15,20].include?(size)
			puts "warning: #{size}x#{size} are not supported"
			size = 10
		end
		# unless  ["fr", "en"].include?(language)
		# 	puts "warning: this language is not supported"
		# 	@language = "FR_fr" #TODO change this to EN_en once the images are done
		# end
		# unless [1024,1280,1440].include?(resolution)
		# 	puts "warning: this resolution is not supported"
		# 	@resolution = 10
		# end
		# @language = Assets::LANGUAGE[language]
		# @resolution = Assets::RESOLUTION[resolution]
		# index = resolution+language+size
		@cellAssets = {
			white: Asset.new(Assets::WHITE["1440FR10"]),
			black: Asset.new(Assets::BLACK["1440FR10"]),
			cross: Asset.new(Assets::CROSS["1440FR10"])
		}
		@cellAssets_selected = {
			white: Asset.new(Assets::WHITE_SELECTED["1440FR10"]),
			black: Asset.new(Assets::BLACK_SELECTED["1440FR10"]),
			cross: Asset.new(Assets::CROSS_SELECTED["1440FR10"])
		}
	end

	def cell_asset(state)
		@cellAssets[state]
	end

	def cell_asset_selected(state)
		@cellAssets_selected[state]
	end

end
