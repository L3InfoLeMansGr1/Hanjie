module Solver
class SetQueue
	# made to contain only index of an array
	def initialize
		@present = []
		@queue = []
	end

	def in(index)
		@queue << index unless @present[index]
		@present[index] = true
		self
	end

	def out
		elt = @queue.shift
		@present[elt] = false
		return elt
	end

	def size
		@queue.size
	end

end # class SetQueue
end # module Solver

if $0 == __FILE__
	f = SetQueue.new
	p f.class
	p f.in(5)
	f.in(6)
	p f
end
