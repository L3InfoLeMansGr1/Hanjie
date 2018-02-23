module Solver
class Block
	@prev # the block before
	@next # the block after
	@first # the first possible cell index
	@last # the last possible cell index
	@size # the length of the block
	@cells # the cells

	attr_reader :size, :first, :last

	def to_s
		"[first:#{@first}, last:#{@last}, size:#{@size}]"
	end

	def initialize(size, cells)
		@size = size
		@cells = cells
	end

	def prev=(blk)
		@prev = blk if @prev == nil
	end

	def next=(blk)
		@next = blk if @next == nil
	end


	def intersection
		return [*(@last - @size + 1)..(@first + @size - 1)]
	end

	def intersections(infos)
		self.intersection.each{|i| infos << i}
		@next.intersections(infos)
	end

	def gap
		return [*(@last+1)..(@next.first-1)].select{|i| i.between?(0, @cells.size-1)}
	end

	def gaps(infos)
		self.gap.each{|i| infos << i}
		@next.gaps(infos)
	end


	# first way:

	# functions to find the smallest solution
	# packed toward the begining of the track

	def packBeginNotRec
		firstPossible = @prev.first + @prev.size + 1
		# puts "previous first #{@prev.first}"
		self.slideFromBegin(firstPossible)
	end

	def packBegin
		self.packBeginNotRec
		# puts "first=#{@first}, size=#{@size}"
		return @next.packBegin
	end


	def bubbleToBegin
		blackBetweenMeAndNext = [*(@first+@size+1)..(@next.first-2)].select{|i|
			# p @cells[i]
			# p i
			@cells[i].state == :black
		}
		if blackBetweenMeAndNext.size > 0
			# p "black cells in between !"
			# p blackBetweenMeAndNext
			# p @cells.map(&:to_s).each_slice(5).map(&:join).join(" ")
			self.slideFromBegin(blackBetweenMeAndNext.max - @size + 1)
			return false unless @next.packBegin
		end

		return @prev.bubbleToBegin
	end

	def slideFromBegin(firstPossible)
		# find the first place where the block can fit
		@first = firstPossible
		last = @first + @size - 1
		max = @cells.size
		while last < max && (whiteCells = [*first..last].select{|i| @cells[i].state == :white}).size > 0
			@first = whiteCells.max + 1
			last = @first + @size - 1
		end

		return false if last >= max

		# if   the upper bound of the block touch a black cell,
		# then make it slide to the end of the black block
		if last+1 < max && @cells[last+1].state == :black
			newLast = last+2
			while newLast < max && @cells[newLast].state == :black
				newLast += 1
			end
			last = newLast - 1
			@first = last - @size + 1
		end

		# now it's needed to verify that the cell in contact whith the block by the first
		# cell of the block is not BLACK.
		if @first > 0 && @cells[first - 1].state == :black
			return slideFromBegin(@first + 1)
		end


		return true
	end


	# second way


	# functions to find the smallest solution
	# packed toward the end of the track

	def packEndNotRec
		lastPossible = @next.last - @next.size - 1
		self.slideFromEnd(lastPossible)
	end

	def packEnd
		self.packEndNotRec
		return @prev.packEnd
	end


	def bubbleToEnd
		blackBetweenMeAndPrev = [*(@prev.last + 2)..(@last - @size - 1)].select{|i|
			@cells[i].state == :black
		}
		if blackBetweenMeAndPrev.size > 0
			self.slideFromEnd(blackBetweenMeAndPrev.min + @size - 1)
			return false unless @prev.packEnd
		end

		return @next.bubbleToEnd
	end

	def slideFromEnd(lastPossible)
		# find the first place where the block can fit
		@last = lastPossible
		first = @last - @size + 1
		while first >= 0 && (whiteCells = [*first..last].select{|i| @cells[i].state == :white}).size > 0
			@last = whiteCells.min - 1
			first = @last - @size + 1
		end

		return false if @first < 0

		# if   the lower bound of the block touch a black cell,
		# then make it slide to the begining of the black block
		if first > 0 && @cells[first-1].state == :black
			newFirst = first-2
			while newFirst >= 0 && @cells[newFirst].state == :black
				newFirst -= 1
			end
			first = newFirst + 1
			@last = first + @size - 1
		end

		# now it's needed to verify that the cell in contact whith the block by the last
		# cell of the block is not BLACK.
		if @last+1 < @cells.size && @cells[last + 1].state == :black
			return slideFromEnd(@last - 1)
		end
		return true
	end

end # class Block
end # module Solver
