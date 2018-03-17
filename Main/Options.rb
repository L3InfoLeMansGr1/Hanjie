require 'yaml'
require 'pathname'
require './Main/MenuAssets'
require './Game/Ui/CellAssets'

class Options

	@resolution
	@language
	@color
	@selectionColor
	@automaticCompletion
	@cellAssets
	@menuAssets

	attr_reader :resolution, :language, :color
	def initialize
		path = Pathname.new(File.dirname(__FILE__) + "/../Preferences.yml")
		data = YAML.load_file(path)
		@cellAssets = CellAssets.getInstance(10)
		@menuAssets = MenuAssets.getInstance()
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
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

	def submit()
		data = {"resolution"=>@resolution, "language"=>@language, "color"=>@color}
		File.open("./Preferences.yml", "w") {|out| out.puts data.to_yaml }
		reload
	end

	def reload()
		@cellAssets.load()
		@menuAssets.load()
	end

end
