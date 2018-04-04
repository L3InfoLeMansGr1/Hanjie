class Moves
	@moves
	@currentPos

	def initialize(moves = [], currentPos = -1)
		@moves = moves
		@currentPos = currentPos
	end

	def add(move)
		@currentPos += 1
		if @moves.length > @currentPos
			@moves.pop(@moves.length-@currentPos)
		end
		@moves << move
	end

	def serialize
		data = @moves.map(&:serialize)
	end

	def replay(game)
		@moves.each { |move|
			move.replay(game)
		}
	end

	def undo(game)
		if @currentPos > -1
			@moves[@currentPos].replayWithoutAdd(game)
			@currentPos -= 1
		end
	end

	def redo(game)
		if(@currentPos < @moves.length-1)
			@currentPos = @currentPos + 1
			@moves[@currentPos].replayWithoutAdd(game)
		end
	end
end
