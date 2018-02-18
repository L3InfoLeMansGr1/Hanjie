##
# A Cell retains a state and an associated right to modify it's state

class Cell
	@@states = [:white, :cross, :black]
	@state  # one of [:crossed :black :white]
	@frozen # if it's frozen it cannot be modified

	attr_reader :state
	def initialize(args={state: :white, frozen: false}) # default value are there only if no args are given
		@state = args[:state]
		@frozen = args[:frozen]
	end

	def frozenOf(cell)
		@state = cell.state
		@frozen = (@state != :white)
	end

	def primaryChange
		return false if @frozen
		case @state
		when :white
			@state = :black
		when :black
			@state = :white
		end
		return true
	end

	def secondaryChange
		return false if @frozen
		case @state
		when :white
			@state = :cross
		when :cross
			@state = :white
		end
		return true
	end
end
