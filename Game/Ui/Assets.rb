require File.dirname(__FILE__) + "/Asset"
require 'yaml'
require 'pathname'
require 'gtk3'

##
# abstract class
# Generates the preferences file used to remember the resolution,
# language, color of the selected cells
class Assets

	@language								#The language of the game
	@resolution							#The resolution of the game
	@color									#The color of the selected grid cell (blue/red/green/yellow/purple)
	@clueHighlightColor			#The color of the highlighted row/column showed from clicking on a help button
	@helpColor							#The color of the position indicator

	private_class_method :new
	attr_accessor :resolution
	attr_accessor :language
	attr_accessor :color

	def initialize()
		load
	end

	def load()
		path = Pathname.new("./Preferences.yml")
		if !path.exist? then
			screenWidth = Gdk::Screen.width()
			screenHeight = Gdk::Screen.height()
			if screenWidth <= 1024 or screenHeight <= 576 then
				puts "This screen is too small to display the game"
			elsif screenWidth <= 1280 or screenHeight <= 720
				resolution = "1024x576"
			elsif screenWidth <= 1440 or screenHeight <= 810
				resolution = "1280x720"
			else
				resolution = "1440x810"
			end
			data = {"resolution"=>resolution,
							"language"=>"FR_fr",
							"color"=>"Blue",
							"clueHighlightColor"=>"Blue",
							"helpColor"=>"Blue"}
			File.open("./Preferences.yml", "w") {|out| out.puts data.to_yaml }
		end
		data = YAML.load_file(path)
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
		@clueHighlightColor = data["clueHighlightColor"]
		@helpColor = data["helpColor"]
	end
end
