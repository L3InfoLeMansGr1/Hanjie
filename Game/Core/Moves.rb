class Moves
	@moves
	@currentPos

	def initialize(moves = [], currentPos = 0)
		@moves = moves
		@currentPos = currentPos
	end

	def add(move)
		#@currentPos += 1
		#@moves.pop(@moves.length-@currentPos)
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

	# def plUndo
	# 	currentPos -= 1
	# 	@moves[currentPos].replay(game)
	# end
	#
	# def plRedo
	# 	currentPos += 1
	# 	@moves[currentPos].replay(game)
	# end
end
