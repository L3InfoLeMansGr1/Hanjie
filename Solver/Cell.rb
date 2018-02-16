module Solver
class Cell
	@@states = [:undefined, :white, :black]
	@state # the state of the cell

	def initialize(state = :undefined)
		@state = state
	end

	attr_reader :state
	def state=(state)
		@state = state if @@states.include?(state)
	end

	def to_s
		repr = {undefined: '?', white: '.', black: '#'}
		return repr[@state]
	end

end # class Cell
end # module Solver
