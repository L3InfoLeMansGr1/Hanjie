class Moves
	@moves

	def initialize(moves = [])
		@moves = moves
	end

	def add(move)
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
end
