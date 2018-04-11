require File.dirname(__FILE__) + "/SetQueue"
require File.dirname(__FILE__) + "/Axe"

module Solver
class Axes
	@queue
	@axes
	def initialize(axes, clues)
		@axes = axes.zip(clues).map{ |cells, blocks|
			# puts cells.map(&:to_s).join + blocks.to_s
			Axe.new(cells, blocks)
		}
		@queue = SetQueue.new
	end

	def addAxe(index)
		@queue.in(index)
		self
	end

	def addAll
		@axes.each_index { |i| addAxe(i) }
		self
	end

	def solve
		nextAxe = @queue.out
		# p nextAxe
		update = @axes[nextAxe].solve
		bis = @axes[nextAxe].solve
		puts "NOOO #{bis.inspect}" if bis != []
		return @axes[nextAxe].solve
	end

	def solved?
		@axes.all?(&:solved?)
	end

	def queueSize
		@queue.size
	end

	def size
		@axes.size
	end

end # class Axes
end # module Solver
