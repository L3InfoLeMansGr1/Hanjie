require File.dirname(__FILE__) + "/Asset"
require 'yaml'
require 'pathname'
require 'gtk3'

class Assets

	@language 										#The language of the game
	@resolution										#The resolution of the game
	@color												#The color of the selected grid cell (blue/red/green/yellow/purple)

	private_class_method :new

	def initialize()
		path = Pathname.new(File.dirname(__FILE__)+ "/../Preferences.yml")
		if !path.exist? then
			screenWidth = Gdk::Screen.width()
			screenHeight = Gdk::Screen.height()
			case [screenWidth, screenHeight]
				when screenWidth < 1024 || screenHeight < 576
						puts "This screen is too small to display the game"
				when screenWidth < 1280 || screenHeight < 720
						resolution = "1024x576"
				when screenWidth < 1440 || screenHeight < 810
						resolution = "1280x720"
				else
						resolution = "1440x810"
			end
			data = {"resolution"=>resolution, "language"=>"FR_fr", "color"=>"Blue"}
			File.open(File.dirname(__FILE__)+ "/../Preferences.yml", "w") {|out| out.puts data.to_yaml }

		end
		data = YAML.load_file(path)
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
	end
end
