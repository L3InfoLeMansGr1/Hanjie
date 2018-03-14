require "./Game/Ui/Asset"
require "./Game/Ui/Assets"

class MenuAssets < Assets

	@@assetInstance = nil 				#Singleton

	private_class_method :new

	def MenuAssets.getInstance()
		if @@assetInstance == nil then
			@@assetInstance = new()
		end
		return @@assetInstance
	end


	def initialize()
		super()
		@menuAssets = {
			newGame: Asset.new(pathToButton("nouvellePartie")),
			loadGame: Asset.new(pathToButton("chargerPartie")),
			options: Asset.new(pathToButton("options")),
			ranking: Asset.new(pathToButton("classement")),
			about: Asset.new(pathToButton("aPropos")),
			quit: Asset.new(pathToButton("quitter")),
			aventure: Asset.new(pathToButton("aventure")),
			timetrial: Asset.new(pathToButton("contreLaMontre")),
			ranked: Asset.new(pathToButton("classe")),
			tutorial: Asset.new(pathToButton("tutoriel")),
			easy: Asset.new(pathToButton("facile")),
			intermediate: Asset.new(pathToButton("intermediaire")),
			hard: Asset.new(pathToButton("difficile")),
			back: Asset.new(pathToButton("retour"))
		}
	end

	def item_asset(name)
		@menuAssets[name]
	end

	def pathToButton(name)
		return  "./Assets/" + @resolution + "/"+ @language + "/Buttons/" + name +".png"
	end

	def pathToTextlessButton(name)
		return  "./Assets/" + @resolution + "/Common/Buttons/" + name +".png"
	end
end
