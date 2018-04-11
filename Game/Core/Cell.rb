##
# A Cell retains a state and an associated right to modify it's state
require File.dirname(__FILE__) + "/../Solver/Solver"

class Cell
	@@states = [:white, :cross, :black]
	@state  # one of [:crossed :black :white]
	@frozen # if it's frozen it cannot be modified
	@solvercell

	attr_reader :state #The state of the Cell one of [:crossed :black :white]
	attr_accessor :frozen #A Boolean, if it's true, you can modify this Cell state, if not you cannot

	##
	# Creates a new Cell object
	# * *Arguments* :
	#   - +state+     -> The state of the Cell one of [:crossed :black :white]
	#   - +frozen+ -> A Boolean, if it's true, you can modify this Cell state, if not you cannot
	def initialize(args={state: :white, frozen: false}) # default value are there only if no args are given
		@state = args[:state]
		@frozen = args[:frozen]
		@solvercell = Solver::Cell.new()
	end


	def frozenOf(cell)
		@state = cell.state
		@frozen = (@state != :white)
	end

	##
	# Apply a primary change on this Cell (left click)
	# * *Returns* :
	#   - A Boolean, if it's true, the change had been executed, if not the cell is frozen
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

	##
	# Apply a secondary change on this Cell (right click)
	# * *Returns* :
	#   - A Boolean, if it's true, the change had been executed, if not the cell is frozen
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

	##
	# Returns the corresponding Solver::Cell
	# * *Returns* :
	#   - Solver::Cell
	def to_solverCell
		@solvercell.state = state
		return @solvercell
	end

	##
	# Reader for @frozen attribute
	# * *Returns* :
	#   -  A Boolean, if it's true, you can modify this Cell state, if not you cannot
	def frozen?
		return @frozen
	end

	def to_s
		@state == :white ? '.' : state == :cross ? 'X' : '#'
	end
end
