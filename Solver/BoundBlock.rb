require File.dirname(__FILE__) + "/Block"

module Solver
class BoundBlock < Block
	# @initialFirst
	# @initialLast

	def initialize(cells)
		super(1, cells)
		@secondStage = false
		@initialFirst = @first
		@initialLast = @last
	end

	def moved?
		@first != @initialFirst || @last != @initialLast
	end
end # class BoundBlock
end # module Solver
