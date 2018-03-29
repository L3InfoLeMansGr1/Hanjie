require File.dirname(__FILE__) + "/Moves"
require File.dirname(__FILE__) + "/Move"
require File.dirname(__FILE__) + "/Game"

class Assists

	@game
	@moves

	def initialize(game)
		@game = game
		@moves = Moves.moves
	end


	def undo

	end

	def redo
		
	end
