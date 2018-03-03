require "./Game/Ui/Asset"

class MenuAssets

	NEWGAME = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/nouvellePartie.png"
	}

	LOADGAME = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/chargerPartie.png"
	}

	OPTIONS = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/options.png"
	}

	RANKING = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/classement.png"
	}

	ABOUT = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/aPropos.png"
	}

	QUIT = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/quitter.png"
	}

	AVENTURE = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/aventure.png"
	}

	TIMETRIAL = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/contreLaMontre.png"
	}

	RANKED = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/classe.png"
	}

	TUTORIAL = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/tutoriel.png"
	}

	EASY = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/facile.png"
	}

	INTERMEDIATE = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/intermediaire.png"
	}

	HARD = {
		"1440FR" => File.dirname(__FILE__) + "/IHM/1440x810/FR_fr/Buttons/difficile.png"
	}


	@@assetInstance = nil 				#Singleton

	private_class_method :new
	def MenuAssets.getInstance()
		if @@assetInstance == nil then
			#@@assetInstance = new(size, resolution, language)
			@@assetInstance = new()
		end
		return @@assetInstance
	end


	def initialize()
		@menuAssets = {
			newGame: Asset.new(MenuAssets::NEWGAME["1440FR"]),
			loadGame: Asset.new(MenuAssets::LOADGAME["1440FR"]),
			options: Asset.new(MenuAssets::OPTIONS["1440FR"]),
			ranking: Asset.new(MenuAssets::RANKING["1440FR"]),
			about: Asset.new(MenuAssets::ABOUT["1440FR"]),
			quit: Asset.new(MenuAssets::QUIT["1440FR"]),
			aventure: Asset.new(MenuAssets::AVENTURE["1440FR"]),
			timetrial: Asset.new(MenuAssets::TIMETRIAL["1440FR"]),
			ranked: Asset.new(MenuAssets::RANKED["1440FR"]),
			tutorial: Asset.new(MenuAssets::TUTORIAL["1440FR"]),
			easy: Asset.new(MenuAssets::EASY["1440FR"]),
			intermediate: Asset.new(MenuAssets::INTERMEDIATE["1440FR"]),
			hard: Asset.new(MenuAssets::HARD["1440FR"])
		}
	end

	def item_asset(name)
		@menuAssets[name]
	end
end
