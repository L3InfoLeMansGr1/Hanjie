require File.dirname(__FILE__) + "/Picture"
require File.dirname(__FILE__) + "/RandomPic"

# Class which permit the generation of grids with different difficulties
class Generator

	##
	# Get a picross grid to play with the diffulty choosen
	# * *Arguments* :
	# +difficulty+ -> The difficulty of the grid
	# * *Returns* :
	# A RandomPic instance
	def self.get(difficulty)
		twenty = RandomPic.creer(20)
		fifteen =  RandomPic.creer(15)
		ten = RandomPic.creer(10)

		#print "Note (10x10): ", ten.grade, "\n"
		#print "Note (15x15): ", fifteen.grade, "\n"
		#print "Note (20x20): ", twenty.grade, "\n"

		res = getAGrid(ten,fifteen,twenty,difficulty)

		#puts difficulty
		#print "Note finale : ",res.grade,"\n"

		return res
	end

	##
	# Get a picross grid to play with the diffulty choosen
	# * *Arguments* :
	# - +diff+ -> The difficulty choosen
	# - +te+ -> RandomPic 10x10
	# - +fif+ -> RandomPic 15x15
	# - +tw+ -> RandomPic 20x20
	# * *Returns* :
	# The RandomPic which match the most with the difficulty given
	def self.getAGrid(te,fif,tw,diff)

		tab = [te,fif,tw].reject{|i| i.grade == -1}

		# Same difficulty (not -1)
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
				return tab.min
			when :intermediate
				if tab.size == 3 then return tab.sort[1]
				else return tab.sort[0]
				end
			when :hard
				return tab.max
			end
		# 2 same difficulty
		elsif !tab.empty? then
			case diff
			when :easy
				return tab.uniq.min
			when :intermediate
				return tab.uniq.min
			when :hard
				return tab.max
			end
		# Impossible way
		else
			get(diff)
		end
	end
end

if $0 == __FILE__

	Generator.get(:intermediate)

end
