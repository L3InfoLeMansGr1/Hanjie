require File.dirname(__FILE__) + "/Asset"
require 'yaml'
require 'pathname'
require 'gtk3'

# abstract class
class Assets

	@language  			#The language of the game
	@resolution			#The resolution of the game
	@color     			#The color of the selected grid cell (blue/red/green/yellow/purple)

	private_class_method :new
	attr_reader :resolution
	attr_reader :language
	attr_reader :color

	def initialize()
		path = Pathname.new("./Preferences.yml")
		if !path.exist? then
			screenWidth = Gdk::Screen.width()
			screenHeight = Gdk::Screen.height()
			puts screenWidth
			puts screenHeight
			if screenWidth <= 1024 or screenHeight <= 576 then
				puts "This screen is too small to display the game"
			elsif screenWidth <= 1280 or screenHeight <= 720
				resolution = "1024x576"
			elsif screenWidth <= 1440 or screenHeight <= 810
				resolution = "1280x720"
			else
				resolution = "1440x810"
			end
			data = {"resolution"=>resolution, "language"=>"FR_fr", "color"=>"Blue"}
			File.open("./Preferences.yml", "w") {|out| out.puts data.to_yaml }
		end
		data = YAML.load_file(path)
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
	end
end
