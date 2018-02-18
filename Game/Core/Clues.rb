##
# An Instance of Clues is a set of clue

def Clues
	attr_reader :clues, :sums
	def initialize(clues)
		@clues = clues.map{|clue| Clue.new(clue)}
		@sums  = clues.map(&:sum)
	end

	def clueAt(index)
		@clues[index]
	end

end
