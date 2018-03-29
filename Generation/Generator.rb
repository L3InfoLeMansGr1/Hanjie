require File.dirname(__FILE__) + "/Picture"
require File.dirname(__FILE__) + "/RandomPic"

class Generator

	def self.get(difficulty)
		twenty = RandomPic.creer(20)
		fifteen =  RandomPic.creer(15)
		ten = RandomPic.creer(10)

		print "Note (10x10): ", ten.grade, "\n"
		print "Note (15x15): ", fifteen.grade, "\n"
		print "Note (20x20): ", twenty.grade, "\n"

		return [twenty, fifteen, ten].max
	end

end

if $0 == __FILE__

	Generator.get(:easy)

end
