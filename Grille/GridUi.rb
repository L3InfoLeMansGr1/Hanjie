require "gtk3"
require "./CellUi"
require "./SelectionUi"
class GridUi

	@rows             # the number of rows
	@cols             # the number of cols
	@gtkGrid          # the associated gtk object
	@grid             # a matrix of all the cells
	@first            # the first cell in an action
	@last             # the last cell in an action
	@currentSelection # a SelectionUi object

	attr_reader :gtkGrid
	attr_writer :first, :last
	attr_reader :first, :last

	##
	# creation of a new grid UI
	# @param args an hash containing the :rows and :cols numbers (both defaults to 1)
	#
	def initialize(args)
		@rows = args.has_key?(:rows) ? args[:rows] : 1
		@cols = args.has_key?(:cols) ? args[:cols] : 1
		@gtkGrid = Gtk::Table.new(@rows, @cols, true) # homogeneous
		@draged = false
		@grid = []
		for i in 0...@rows
			@grid[i] = []
			for j in 0...@cols
				cell = CellUi.new(self, i, j)
				@grid[i] << cell
				@gtkGrid.attach(cell.gtkButton, j, j+1, i, i+1)
			end
		end
		@currentSelection = SelectionUi.new(Gdk::RGBA.parse("#ffffff"), Gdk::RGBA.parse("#aaaaff"))
	end


	def say(msg) # :nodoc:
		puts "GRID: #{msg}"
	end

	##
	# called when a right click occur on the grid
	#
	def rightClicked
		self.say("#{__method__} at #{@first}")
	end

	##
	# called when a left click occur on the grid
	#
	def leftClicked
		self.say("#{__method__} at #{@first}")
	end

	##
	# called when a draged right click occur on the grid
	#
	def rightClicked_draged
		return rightClicked unless draged?
		self.say("#{__method__} from #{@first} to #{@last}")
	end

	##
	# called when a draged left click occur on the grid
	#
	def leftClicked_draged
		return leftClicked unless draged?
		self.say("#{__method__} from #{@first} to #{@last}")

	end

	def endDrag # :nodoc:
		@first = @last = nil
		@currentSelection.update([])
		@currentSelection.show()
	end

	##
	# Draws a visual selection for the user
	#
	def selection
		# say("selection from #{@first} to #{@last} => realLast:#{realLast}")

		last = self.realLast

		rowsBound = [@first.row, last.row]
		firstRow  = rowsBound.min
		lastRow   = rowsBound.max

		colsBound = [@first.col, last.col]
		firstCol  = colsBound.min
		lastCol   = colsBound.max

		newSelection = []
		[*firstRow..lastRow].each { |row|
			[*firstCol..lastCol].each { |col|
				newSelection << @grid[row][col].gtkButton
			}
		}

		@currentSelection.update(newSelection)
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
			return @grid[@last.row][@first.col]
		else       # the selection is horizontal
			return @grid[@first.row][@last.col]
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
