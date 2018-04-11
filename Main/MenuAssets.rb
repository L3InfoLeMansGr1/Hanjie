require File.dirname(__FILE__) + "/../Game/Ui/Asset"
require File.dirname(__FILE__) + "/../Game/Ui/Assets"

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
			back: Asset.new(pathToButton("retour")),
			load: Asset.new(pathToButton("charger")),
			delete: Asset.new(pathToButton("supprimer")),
			validate: Asset.new(pathToButton("valider")),
			previous: Asset.new(pathToButton("précédent")),
			next: Asset.new(pathToButton("suivant"))
		}

		@menuAssetsSelected = {
			newGame: Asset.new(pathToButton("nouvellePartieOn")),
			loadGame: Asset.new(pathToButton("chargerPartieOn")),
			options: Asset.new(pathToButton("optionsOn")),
			ranking: Asset.new(pathToButton("classementOn")),
			about: Asset.new(pathToButton("aProposOn")),
			quit: Asset.new(pathToButton("quitterOn")),
			aventure: Asset.new(pathToButton("aventureOn")),
			timetrial: Asset.new(pathToButton("contreLaMontreOn")),
			ranked: Asset.new(pathToButton("classeOn")),
			tutorial: Asset.new(pathToButton("tutorielOn")),
			easy: Asset.new(pathToButton("facileOn")),
			intermediate: Asset.new(pathToButton("intermediaireOn")),
			hard: Asset.new(pathToButton("difficileOn")),
			back: Asset.new(pathToButton("retourOn")),
			load: Asset.new(pathToButton("chargerOn")),
			delete: Asset.new(pathToButton("supprimerOn")),
			validate: Asset.new(pathToButton("validerOn")),
			previous: Asset.new(pathToButton("précédentOn")),
			next: Asset.new(pathToButton("suivantOn"))
		}
	end

	def item_asset(name)
		@menuAssets[name]
	end

	def item_asset_selected(name)
		@menuAssetsSelected[name]
	end

	def pathToButton(name)
		return  File.dirname(__FILE__) + "/../Assets/" + @resolution + "/"+ @language + "/Buttons/" + name +".png"
	end

	def pathToTextlessButton(name)
		return  File.dirname(__FILE__) + "/../Assets/" + @resolution + "/Common/Buttons/" + name +".png"
	end
end
