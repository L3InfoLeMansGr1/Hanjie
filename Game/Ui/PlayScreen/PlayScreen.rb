require "gtk3"
require File.dirname(__FILE__) + "/GameButton"
require File.dirname(__FILE__) + "/Terminal"
require File.dirname(__FILE__) + "/ChronoUi"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"
require File.dirname(__FILE__) + "/../../Core/Moves"

class PlayScreen
  @chTable
  @controlPanel
  @chrono
  @gridBox
  @grid
  @gtkObject
	@gridUi
  attr_reader :gtkObject

  def initialize(grid)
    @assets = MenuAssets.getInstance
    @grid = grid.gtkObject
		@gridUi = grid
    @gridBox = Gtk::EventBox.new
    @gridBox.add(@grid)
    @boardUi = Gtk::Table.new(1,3)
    # CONTROL PANEL
    @controlPanel = Gtk::Table.new(11,11)
    # CHRONO BUTTON
    @chrono = ChronoUi.new(grid.game.timer,self)
    # TERMINAL
    term = Terminal.new(@grid)
    # HYPOTHESIS BUTTONS
    newH = GameButton.new("blue"){}
    applyH = GameButton.new("green"){}
    cancelH = GameButton.new("red"){}
    # HELP BUTTONS
    h1 = GameButton.new("aide1",){
			highlight()
		}
    h2 = GameButton.new("aide2"){
			highlightAndGiveTechniq()
		}
    ud = GameButton.new("undo"){
		}
    rd = GameButton.new("redo"){puts "1"}
    cl = GameButton.new("clear"){puts "1"}

    # CHRONO PLACEMENT
    @controlPanel.attach(Gtk::Label.new("\n\n\n\n\n"), 0, 10, 0, 1) # triche grossière mais j'ai pas mieux
    @controlPanel.attach(@chrono.gtkObject, 3, 4, 1, 2)

    @controlPanel.attach(Gtk::Label.new("\n\n\n\n\n\n\n"), 0, 10, 2, 6) # triche grossière mais j'ai pas mieux
    # FIRST ROW / FIRST COL
    @controlPanel.attach(newH.gtkObject,    0, 1, 6, 7)
    @controlPanel.attach(applyH.gtkObject,  1, 2, 6, 7)
    @controlPanel.attach(cancelH.gtkObject, 2, 3, 6, 7)

    @controlPanel.attach(Gtk::Label.new("\n\n"), 0, 10, 7, 8) # triche grossière mais j'ai pas mieux

    # SECOND ROW / FIRST COL
    @controlPanel.attach(ud.gtkObject, 0, 1, 8, 9)
    @controlPanel.attach(rd.gtkObject, 1, 2, 8, 9)
    @controlPanel.attach(cl.gtkObject, 2, 3, 8, 9)

    @controlPanel.attach(Gtk::Label.new("\t\t"), 3, 4, 0, 11) # triche grossière mais j'ai pas mieux

    # FIRST ROW / SECOND COL
    @controlPanel.attach(h1.gtkObject, 4, 6, 6, 7)
    @controlPanel.attach(h2.gtkObject, 6, 8, 6, 7)

    @controlPanel.attach(Gtk::Label.new("\n"), 4, 8, 8, 9) # triche grossière mais j'ai pas mieux
    # SECOND ROW / SECOND COL
    @controlPanel.attach(term.gtkObject,    4, 8, 8, 9)

    @controlPanel.attach(Gtk::Label.new("\t\t"), 10, 11, 0, 11) # triche grossière mais j'ai pas mieux
    @controlPanel.attach(Gtk::Label.new("\n"), 0, 10, 9, 10) # triche grossière mais j'ai pas mieux

    # GLOBAL
    @boardUi.attach(@gridBox,      0, 1, 0, 1)
    @boardUi.attach(@controlPanel, 1, 2, 0, 1)

    @gtkObject = @boardUi
  end

  def run
    @chrono.start
  end

  def showgrid
    @boardUi.attach(@gridBox,      0, 1, 0, 1)
  end

  def hideGrid
    @boardUi.remove(@gridBox)
  end

	def highlightAndGiveTechniq
		highlight()
	end
	def highlight
		nrow = @gridUi.game.nRow
		ncol = @gridUi.game.nCol
		trouve = false
		indFound = -1
		isRow = true
		# p @gridCore.game
		0.upto(nrow-1) do |ind|
			row =  @gridUi.game.getSolverRow(ind)
			if(!row.solved?)# p row
			if(row.solver_intersections.size > 0)
				puts "intersection trouvée sur la ligne"+ind.to_s
				trouve = true
				indFound = ind
				break;
			end
			if(row.solver_gaps.size > 0)
				puts "gaps trouvée sur la ligne"+ind.to_s
				trouve = true
				indFound = ind
				break;
			end
			if(row.solver_minMaxPossibleSize.size > 0)
				puts "minmax trouvée sur la ligne"+ind.to_s
				trouve = true
				indFound = ind
				break;
			end
			if(row.solver_littleGapsInRange.size > 0)
				puts "little gaps trouvée sur la ligne"+ind.to_s
				trouve = true
				indFound = ind
				break;
			end
			end
		end
		if !trouve
			isRow=false
			0.upto(ncol-1) do |ind|
				col =  @gridUi.game.getSolverCol(ind)
				if(!col.solved?)
				if(col.solver_intersections.size > 0)
					puts "intersection trouvée sur la colonne"+ind.to_s
					indFound = ind
					trouve = true
					break;
				end
				if(col.solver_gaps.size > 0)
					puts "gaps trouvée sur la colonne"+ind.to_s
					indFound = ind
					trouve = true
					break;
				end
				if(col.solver_minMaxPossibleSize.size > 0)
					puts "minmax trouvée sur la colonne"+ind.to_s
					indFound = ind
					trouve = true
					break;
				end
				if(col.solver_littleGapsInRange.size > 0)
					puts "little gaps trouvée sur la colonne"+ind.to_s
					indFound = ind
					trouve = true
					break;
				end
				end
			end
		end
		if(trouve)
			@chrono.chrono.add_seconds(15)
			selection = SelectionUi.new()
			# p  @gridUi.colAt(indFound)
			p isRow
			if isRow
				cells = @gridUi.rowAt(indFound)
			else
				cells = @gridUi.colAt(indFound)
			end
			puts cells
			selection.select( cells )
			GLib::Timeout.add(3000){
				selection.unselect( cells )
				#Required unless this block will be repaeated again and again
				FALSE
			}
		end
	end

end
