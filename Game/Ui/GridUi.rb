require "gtk3"
require File.dirname(__FILE__) + "/CellUi"
require File.dirname(__FILE__) + "/SelectionUi"
require File.dirname(__FILE__) + "/ClueUi"
require File.dirname(__FILE__) + "/Click"
require File.dirname(__FILE__) + "/Preview"

class GridUi

	@gtkObject          # the associated gtk object
	@cells            # a matrix of all the cells
	@first            # the first cell in an action
	@last             # the last cell in an action
	@currentSelection # a SelectionUi object
	@game             # The game
	@rowClues         # all the clues for the rows
	@colClues         # all the clues for the cols
	@assets
	@preview
	@click


	attr_reader :gtkObject
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

		# cration of the UI version of the clues
		@rowClues = game.rowClues.each_with_index.map { |clue, i| ClueUi.new(:horizontal, clue, i) }
		@colClues = game.colClues.each_with_index.map { |clue, i| ClueUi.new(:vertical,   clue, i) }

		# creation of the UI version of the cells
		@cells = (0...nRow).map { |r|
			(0...nCol).map { |c|
				CellUi.new(self, r, c, @assets)
			}
		}
		@preview = Preview.new

		# creation of the grid itself
		initGtkGrid()


		@gtkObject.signal_connect("button_release_event") { |_, event|
			if (@click == event.button)
				case event.button
				when Click::RIGHT
					rightClicked_draged()
				when Click::LEFT
					leftClicked_draged()
				end
			end

			endDrag()
		}

		# comment the lines below to test without the bug
		@gtkObject.signal_connect("leave_notify_event") { |widget, event|
			# puts event.detail.nick
			endDrag() if event.detail.nick != "inferior" # pry save us all
		}

		@currentSelection = SelectionUi.new
	end

	def initGtkGrid
		mainSpacing = 5
		subSpacing = 1

		realGrid = Gtk::Grid.new
		realGrid.set_column_spacing(mainSpacing)
		realGrid.set_row_spacing(mainSpacing)

		group = 5 # division of the grid in groups of size group x group

		# here to get this ruby magic line, take a paper and pencil and draw an example (complicated enough)
		subGrids = @cells.map {|row|
			row.each_slice(group).to_a
		}.transpose.map { |row|
			row.each_slice(group).to_a
		}.transpose

		# create every corresponding gtk subGrid and keep a reference to them for potenial future usage
		@gtkCellSubGrids = subGrids.each_with_index.map { |rowOfSubGrid, r|
			rowOfSubGrid.each_with_index.map { |subGrid, c|
				gtkSubGrid = Gtk::Grid.new
				gtkSubGrid.set_column_spacing(subSpacing)
				gtkSubGrid.set_row_spacing(subSpacing)

				# attach all the cells to it
				subGrid.each_with_index {|row, i|
					row.each_with_index {|cell, j|
						gtkSubGrid.attach(cell.gtkObject, j, i, 1, 1)
					}
				}

				# attach it to the main grid
				realGrid.attach(gtkSubGrid, c+1, r+1, 1, 1)

				# return the gtkSubGrid
				gtkSubGrid
			}
		}

		# create subBoxes for the clues on the sides
		rowCluesSubBoxes, colCluesSubBoxes = [@rowClues, @colClues].map {|clues|
			clues.each_slice(group).to_a
		}
		# and then the corresponding gtk objects
		@gtkRowCluesSubBoxes, @gtkColCluesSubBoxes = [
			[rowCluesSubBoxes, :vertical],
			[colCluesSubBoxes, :horizontal]
		].map {|subBoxes, orientation|
			subBoxes.map { |subBox|

				gtkBox = Gtk::Box.new(orientation, subSpacing)
				subBox.each {|clue| gtkBox.pack_start(clue.gtkObject, expand:true, fill:false)}
				gtkBox # return the gtkBox
			}
		}

		# attach them to the main grid
		@gtkRowCluesSubBoxes.each_with_index {|subBox, i|
			realGrid.attach(subBox, 0, i+1, 1, 1)
		}

		@gtkColCluesSubBoxes.each_with_index {|subBox, i|
			realGrid.attach(subBox, i+1, 0, 1, 1)
		}

		realGrid.attach(@preview.gtkObject, 0,0,1,1)

		@gtkObject = Gtk::EventBox.new

		@gtkObject.add(realGrid)

	end


	def say(msg) # :nodoc:
		puts "GRID: #{msg}"
	end

	def coreCellAt(row, col)
		@game.cellAt(row, col)
	end

	##
	# called when a right click occur on the grid
	#
	def rightClicked
		# self.say("#{__method__} at #{@first}")
		@first.rightClicked
	end

	##
	# called when a left click occur on the grid
	#
	def leftClicked
		# self.say("#{__method__} at #{@first}")
		@first.leftClicked
	end

	##
	# called when a draged right click occur on the grid
	#
	def rightClicked_draged
		return unless clickdefined?
		return rightClicked unless draged?
		# self.say("#{__method__} from #{@first} to #{@last}")
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
		return unless clickdefined?
		return leftClicked unless draged?
		# self.say("#{__method__} from #{@first} to #{@last}")
		sameState = cellsFromFirstToEnd.select { |cell|
			cell.sameState?(@first)
		}

		sameState.each { |cell|
			@first = cell
			leftClicked()
		}
	end

	def beginDrag(cell, click)
		return endDrag if draged?
		@first = cell
		@click = click
		selection(cell)
	end

	def endDrag # :nodoc:
		@first = @last = nil
		@currentSelection.update([])
		@currentSelection.show()
	end

	def cellsFromFirstToEnd
		last = self.realLast

		firstRow, lastRow = [@first.row, last.row].minmax

		firstCol, lastCol = [@first.col, last.col].minmax

		cells = []
		(firstRow..lastRow).each { |row|
			(firstCol..lastCol).each { |col|
				cells << @cells[row][col]
			}
		}
		return cells
	end

	##
	# Draws a visual selection for the user
	#
	def selection(cell)
		@last = cell
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
		@first != nil
	end

	def clickdefined?
		@last != nil && @first != nil
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

	win.add(grid.gtkObject)
	win.show_all
	Gtk.main
end
