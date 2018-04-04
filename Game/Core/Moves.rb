class Moves
	@moves
	@currentPos

	def initialize(moves = [], currentPos = -1)
		@moves = moves
		@currentPos = currentPos
				puts "Init : Current Pos" + @currentPos.to_s
				puts "Init : moves.length " + @moves.length.to_s
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
		if(@currentPos < @moves.length)
			@moves[@currentPos].replayWithoutAdd(game)
			@currentPos = @currentPos + 1
		end
	end
end
