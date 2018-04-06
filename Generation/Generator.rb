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

		res = getAGrid(ten,fifteen,twenty,difficulty)
		puts difficulty
		print "Note finale : ",res.grade,"\n"
		return res

		#return [twenty, fifteen, ten].max
	end

	def self.getAGrid(te,fif,tw,diff)
		# Same difficulty
		if te == fif && fif == tw then
			case diff
			when :easy
				return te
			when :intermediate
				return fif
			when :hard
				return tw
			end
		# Different difficulty
		elsif te != fif && fif != tw then
			case diff
			when :easy
				return [tw, fif, te].min
			when :intermediate
				return [tw, fif, te].sort[1]
			when :hard
				return[tw, fif, te].max
			end
		else
			case diff
			when :easy
				return [tw,fif,te].uniq.min
			when :intermediate
				return [tw,fif,te].uniq.min
			when :hard
				return [tw,fif,te].max
			end
		end
	end
end

if $0 == __FILE__

	Generator.get(:intermediate)

end
