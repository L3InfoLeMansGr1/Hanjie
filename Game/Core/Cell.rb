##
# A Cell retains a state and an associated right to modify it's state

class Cell
	@@states = [:empty, :cross, :black]
	@state  # one of [:crossed :black :white]
	@frozen # if it's frozen it cannot be modified

	attr_reader :state
	def initialize(args={state: :empty, frozen: false})
		@state = args[:state]
		@frozen = args[:frozen]
	end

	def primaryChange
		return false if @frozen
		case @state
		when :empty
			@state = :black
		when :black
			@state = :empty
		end
		return true
	end

	def secondaryChange
		return false if @frozen
		case @state
		when :empty
			@state = :cross
		when :cross
			@state = :empty
		end
		return true
	end
end
