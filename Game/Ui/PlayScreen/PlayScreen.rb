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

  attr_reader :gtkObject

  def initialize(grid)
    @assets = MenuAssets.getInstance
    @grid = grid.gtkObject
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
    h1 = GameButton.new("aide1"){puts 1}
		# 		nrow = grid.game.nRow
		# 		ncol = grid.game.nCol
		# 		0.upto(nrow-1) do |ind|
		# 			row =  grid.game.getSolverRow(ind)
		# 			#if (row.solver_intersections
		# 			row.solver_gaps
		# 			row.solver_littleGapsInRange
		# 			row.solver_minMaxPossibleSize
		# 		end
		# 		0.upto(ncol-1) do |ind|
		# 			col =  grid.game.getSolverCol(ind)
		# 			p col.solver_intersections
		# 			p col.solver_gaps
		# 			p col.solver_littleGapsInRange
		# 			p col.solver_minMaxPossibleSize
		# 		end
		# }
    h2 = GameButton.new("aide2"){puts "1"}
    ud = GameButton.new("undo"){puts "1"}
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

end
