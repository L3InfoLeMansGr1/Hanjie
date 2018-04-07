require 'yaml'
require 'pathname'
require './Main/MenuAssets'
require './Game/Ui/CellAssets'

class Options

	@language								#The language of the game
	@resolution							#The resolution of the game
	@color									#The color of the selected grid cell (blue/red/green/yellow/purple)
	@clueHighlightColor			#The color of the highlighted row/column showed from clicking on a help button
	@helpColor							#The color of the position indicator
	@automaticCompletion
	@cellAssets
	@menuAssets

	attr_reader :resolution, :language, :color
	def initialize
		path = Pathname.new(File.dirname(__FILE__) + "/../Preferences.yml")
		data = YAML.load_file(path)
		@menuAssets = MenuAssets.getInstance()
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
		@clueHighlightColor = data["clueHighlightColor"]
		@helpColor = data["helpColor"]
	end

	def setResolution(res)
		@resolution = res
	end

	def setColor(color)
		@color = color

	end

	def setLanguage(language)
		@language = language
	end

	def setClueHighlightColor(clueHighlightColor)
		@clueHighlightColor=clueHighlightColor
	end

	def setHelpColor(helpColor)
		@helpColor = helpColor
	end

	def submit()
		data = {"resolution"=>@resolution, "language"=>@language, "color"=>@color}
		File.open("./Preferences.yml", "w") {|out| out.puts data.to_yaml }
		@menuAssets.load()
	end

end
