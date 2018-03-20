require "gtk3"
require File.dirname(__FILE__) + "/GameButton"
require File.dirname(__FILE__) + "/Terminal"
require File.dirname(__FILE__) + "/ChronoUi"
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"
require File.dirname(__FILE__) + "/../../Core/Chronometre"

class PlayScreen
  @chTable
  @controlPanel
  @chorno
  @gridBox
  @grid
  @gtkObject

  attr_reader :gtkObject

  def initialize(grid,mode,time = 0)
    @assets = MenuAssets.getInstance
    @grid = grid
    @gridBox = Gtk::EventBox.new
    @gridBox.add(@grid)
    @boardUi = Gtk::Table.new(1,3)
    # CONTROL PANEL
    @controlPanel = Gtk::Table.new(11,11)
    # CHRONO BUTTON
    @chrono = ChronoUi.new(mode,time,self)
    # TERMINAL
    term = Terminal.new(@grid)
    # HYPOTHESIS BUTTONS
    newH = GameButton.new("blue","newHypothesis")
    applyH = GameButton.new("green","applyHypothesis")
    cancelH = GameButton.new("red","cancelHypothesis")
    # HELP BUTTONS
    h1 = GameButton.new("aide1","help1")
    h2 = GameButton.new("aide2","help2")
    ud = GameButton.new("undo","undo")
    rd = GameButton.new("redo","redo")
    cl = GameButton.new("clear","clear")

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
