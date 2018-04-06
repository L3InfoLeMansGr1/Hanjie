class Moves
	@moves
	@redo

	def initialize(moves = [])
		@moves = moves
		@redo = []
	end

	def add(move)
		@currentPos += 1
		if @moves.length > @currentPos
			@moves.pop(@moves.length-@currentPos)
		end
		@moves << move
		@redo.clear
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
		if @moves.last != nil
			@moves.last.replayWithoutAdd(game)
			@redo.push(@moves.pop)
			return @redo.last.cellsPos
		end
		return []
	end

	def redo(game)
		if @redo.last != nil
			@redo.last.replayWithoutAdd(game)
			@moves.push(@redo.pop)
			return @moves.last.cellsPos
		end
		return []
	end
end
