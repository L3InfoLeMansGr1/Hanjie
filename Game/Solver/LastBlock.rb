require File.dirname(__FILE__) + "/BoundBlock"

module Solver
class LastBlock < BoundBlock

	def intersections(infos)
		infos.select!{|i| @cells[i].state == :white}
		infos.each {|i| @cells[i].state = :black}
	end

	def gaps(infos)
		infos.select!{|i| @cells[i].state == :white}
		infos.each {|i| @cells[i].state = :cross}
	end

	def initialize(cells)
		@first = cells.size + 1
		@last = @first
		super(cells)
	end

	# first way
	def packBegin
		self.packBeginNotRec
		return false if self.moved?
		# if !@secondStage
		# 	@secondStage = true
		# 	return @prev.bubbleToBegin
		# else
		# 	return true
		# end
		return @prev.bubbleToBegin
	end

	def slideFromBegin(firstPossible)
		if @first < firstPossible
			@first = firstPossible
		end
	end



	# second way:

	def compact
		return @prev.packEnd
	end

	def bubbleToEnd
		return [*(@prev.last + 2)..(@last - @size - 1)].all?{|i|
			@cells[i].state != :black
		}
	end

end # class LastBlock
end # module Solver
