##
# A Cell retains a state and an associated right to modify it's state
require File.dirname(__FILE__) + "/../Solver/Solver"

class Cell
	@@states = [:white, :cross, :black]
	@state  # one of [:crossed :black :white]
	@frozen # if it's frozen it cannot be modified
	@solvercell

	attr_reader :state
	attr_accessor :frozen

	def initialize(args={state: :white, frozen: false}) # default value are there only if no args are given
		@state = args[:state]
		@frozen = args[:frozen]
		@solvercell = Solver::Cell.new()
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

	def to_solverCell
		@solvercell.state = state
		return @solvercell
	end

	def to_s
		@state == :white ? '.' : state == :cross ? 'X' : '#'
	end
end
