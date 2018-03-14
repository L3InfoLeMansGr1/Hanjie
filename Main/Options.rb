require 'yaml'
require 'pathname'

class Options

	@resolution
	@language
	@color

	attr_reader :resolution, :language, :color
	def initialize
		path = Pathname.new("./Preferences.yml")
		data = YAML.load_file(path)
		@language = data["language"]
		@resolution = data["resolution"]
		@color = data["color"]
	end

	def setResolution(res)
	end

	def setColor(color)
	end

	def setLanguage(language)
	end

end
