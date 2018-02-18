require "gtk3"
require File.dirname(__FILE__) + "/CellUi"
require File.dirname(__FILE__) + "/SelectionUi"
require File.dirname(__FILE__) + "/ClueUi"

class GridUi

	# @rows             # the number of rows
	# @cols             # the number of cols
	@gtkGrid          # the associated gtk object
	@cells            # a matrix of all the cells
	@first            # the first cell in an action
	@last             # the last cell in an action
	@currentSelection # a SelectionUi object
	@game             # The game
	@rowClues         # all the clues for the rows
	@colClues         # all the clues for the cols
	@assets


	attr_reader :gtkGrid
	attr_writer :first, :last
	attr_reader :first, :last
	attr_reader :game

	##
	# creation of a new grid UI
	# @param game the current game
	#
	def initialize(game, assets)
		nRow = game.nRow
		nCol = game.nCol
		@game = game
		@assets = assets
		# @gtkGrid = Gtk::Table.new(nRow, nCol, true) # homogeneous
		@gtkGrid = Gtk::Grid.new
		@gtkGrid.add(Gtk::Button.new(title:"useless"))
		@cells = []
		@rowClues = game.rowClues.each_with_index.map { |clue, i| ClueUi.new(:horizontal, clue, i) }
		@colClues = game.colClues.each_with_index.map { |clue, i| ClueUi.new(:vertical,   clue, i) }
		for i in 0...nRow
			@gtkGrid.attach(@rowClues[i].gtkButton, 0, i+1, 1, 1)

			row = []
			for j in 0...nCol
				@gtkGrid.attach(@colClues[j].gtkButton, j+1, 0, 1, 1)

				cell = CellUi.new(self, i, j, @assets)
				row << cell
				@gtkGrid.attach(cell.gtkButton, j+1, i+1, 1, 1)
				# @gtkGrid.attach(cell.gtkButton, j+1, j+2, i+1, i+2)
			end
			@cells << row
		end
		@currentSelection = SelectionUi.new
		# @currentSelection = SelectionUi.new(Assets.new(nRow))
		# @currentSelection = SelectionUi.new(Gdk::RGBA.parse("#ffffff"), Gdk::RGBA.parse("#aaaaff"))
	end


	def say(msg) # :nodoc:
		puts "GRID: #{msg}"
	end

	##
	# called when a right click occur on the grid
	#
	def rightClicked
		self.say("#{__method__} at #{@first}")
		@first.coreCell.secondaryChange
		@first.normal
		@first.show
	end

	##
	# called when a left click occur on the grid
	#
	def leftClicked
		self.say("#{__method__} at #{@first}")
		@first.coreCell.primaryChange
		@first.normal
		@first.show
	end

	##
	# called when a draged right click occur on the grid
	#
	def rightClicked_draged
		return rightClicked unless draged?
		self.say("#{__method__} from #{@first} to #{@last}")
		sameState = cellsFromFirstToEnd.select { |cell|
			cell.sameState?(@first)
		}

		sameState.each { |cell|
			@first = cell
			rightClicked()
		}
	end

	##
	# called when a draged left click occur on the grid
	#
	def leftClicked_draged
		return leftClicked unless draged?
		self.say("#{__method__} from #{@first} to #{@last}")
		sameState = cellsFromFirstToEnd.select { |cell|
			cell.sameState?(@first)
		}

		sameState.each { |cell|
			@first = cell
			leftClicked()
		}
	end

	def endDrag # :nodoc:
		@first = @last = nil
		@currentSelection.update([])
		@currentSelection.show()
	end

	def cellsFromFirstToEnd
		last = self.realLast

		rowsBound = [@first.row, last.row]
		firstRow  = rowsBound.min
		lastRow   = rowsBound.max

		colsBound = [@first.col, last.col]
		firstCol  = colsBound.min
		lastCol   = colsBound.max

		cells = []
		[*firstRow..lastRow].each { |row|
			[*firstCol..lastCol].each { |col|
				cells << @cells[row][col]
			}
		}
		return cells
	end

	##
	# Draws a visual selection for the user
	#
	def selection
		# say("selection from #{@first} to #{@last} => realLast:#{realLast}")

		@currentSelection.update(cellsFromFirstToEnd())
		@currentSelection.show()
	end

	##
	# Compute the real last cell of the selection
	# @return CellUi
	#
	def realLast
		dc = (@first.col - @last.col).abs
		dr = (@first.row - @last.row).abs

		if dc < dr # then the selection vertical
			return @cells[@last.row][@first.col]
		else       # the selection is horizontal
			return @cells[@first.row][@last.col]
		end
	end

	def draged?
		@last != @first
	end
end

if $0 == __FILE__
	grid = GridUi.new(rows:20, cols:25)

	win = Gtk::Window.new
	win.title = "GridUi Demo"
	win.signal_connect('delete_event') {
		Gtk.main_quit
		false
	}

	win.add(grid.gtkGrid)
	win.show_all
	Gtk.main
end
