require File.dirname(__FILE__) + "/BoundBlock"

module Solver
class FirstBlock < BoundBlock

	def initialize(cells)
		@first = -2
		@last = -2
		super(cells)
	end

	def intersections
		infos = []
		@next.intersections(infos)
		return infos
	end

	def gaps
		infos = []
		super(infos)
		return infos
	end

	# first way:
	def compact
		return @next.packBegin
	end

	def bubbleToBegin
		return [*(@first+@size+1)..(@next.first-2)].all?{|i|
			@cells[i].state != :black
		}
	end


	#second way:
	def packEnd
		self.packEndNotRec
		return false if self.moved?
		# if !@secondStage
		# 	@secondStage = true
		# 	return @next.bubbleToEnd
		# else
		# 	return true
		# end
		return @next.bubbleToEnd
	end

	def slideFromEnd(lastPossible)
		if @last > lastPossible
			@last = lastPossible
		end
	end
end # class FirstBlock
end # module Solver
