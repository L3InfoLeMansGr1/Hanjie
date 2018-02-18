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

	def replay(file, game)
		# it's not the IV @moves in purpose
		moves = file.read # TODO
		moves.each { |move|
			move.replay(game)
		}
	end
end
