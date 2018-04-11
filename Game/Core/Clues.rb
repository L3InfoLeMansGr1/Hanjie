##
# An Instance of Clues is a List of clue

def Clues
	attr_reader :clues # A List of Clue
	attr_reader :sums # A List of sums

	##
	# Creates a new Clues object
	# * *Arguments* :
	#   - +clues+     -> The List of Clue
	def initialize(clues)
		@clues = clues.map{|clue| Clue.new(clue)}
		@sums  = clues.map(&:sum)
	end

	##
	# Returns the Clue at the given index
	# * *Arguments* :
	#   - +index+     -> The index of The wanted Clue
	# * *Returns* :
	#   - The Clue
	def clueAt(index)
		@clues[index]
	end

	##
	# Returns the sum at the given index
	# * *Arguments* :
	#   - +index+     -> The index of The wanted sum
	# * *Returns* :
	#   - The sum
	def sumAt(index)
		@sums[index]
	end

end
