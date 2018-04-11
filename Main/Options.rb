require 'yaml'
require 'pathname'
require './Main/MenuAssets'
require './Game/Ui/CellAssets'

##
#Representation of user settings and preferences
class Options

	@language								#The language of the game
	@resolution							#The resolution of the game
	@color									#The color of the selected grid cell (blue/red/green/yellow/purple)
	@clueHighlightColor			#The color of the highlighted row/column showed from clicking on a help button
	@helpColor							#The color of the position indicator
	@menuAssets							#MenuAssets reference


	attr_reader :resolution #The resolution of the Game
	attr_reader :language #The language of the Game
	attr_reader :color #The Selection color

	##
	# Creates a new Options object
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


	##
	# Sets the resolution to the given one
	# * *Arguments* :
	#   - +res+     -> a String respresenting the resolution
	def setResolution(res)
		@resolution = res
	end

	##
	# Sets the color to the given one
	# * *Arguments* :
	#   - +color+     -> a String respresenting the color
	def setColor(color)
		@color = color

	end

	##
	# Sets the language to the given one
	# * *Arguments* :
	#   - +language+     -> a String respresenting the language
	def setLanguage(language)
		@language = language
	end

	##
	# Sets the clue highlight color to the given one
	# * *Arguments* :
	#   - +clueHighlightColor+     -> a String respresenting the clue highlight color
	def setClueHighlightColor(clueHighlightColor)
		@clueHighlightColor=clueHighlightColor
	end

	##
	# Sets the help color to the given one
	# * *Arguments* :
	#   - +helpColor+     -> a String respresenting the help color
	def setHelpColor(helpColor)
		@helpColor = helpColor
	end

	##
	# Writes user prefrences into "Preferences.yml"
	def submit()
		data = {"resolution"=>@resolution, "language"=>@language, "color"=>@color}
		File.open("./Preferences.yml", "w") {|out| out.puts data.to_yaml }
		@menuAssets.load()
	end

end
