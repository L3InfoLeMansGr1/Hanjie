module Solver
class Cell
	@@states = [:white, :cross, :black]
	@state # the state of the cell

	def initialize(state = :white)
		@state = state
	end

	attr_reader :state
	def state=(state)
		@state = state if @@states.include?(state)
	end

	def to_s
		repr = {white: '?', cross: '.', black: '#'}
		return repr[@state]
	end

end # class Cell
end # module Solver
