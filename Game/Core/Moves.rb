class Moves
	@moves
	@redo

	attr_reader :moves

	def initialize(moves = [])
		@moves = moves
		@redo = []
	end

	def add(move)
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
