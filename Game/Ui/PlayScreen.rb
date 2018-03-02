require "gtk3"
require "./Ui/GameButton"
require "../Grille/Chronometre"
require "./Ui/PauseScreen"

class PlayScreen
  @win
  @chTable
  @controlPanel
  @chorno
  @gridBox
  @background
  @grid

  def initialize(grid,mode,time = 0)
    @grid = grid
    @gridBox = Gtk::EventBox.new
    @gridBox.add(@grid)
    @win = Gtk::Window.new
    @win.title = "Tsunamii"
    @win.set_resizable(false)
    @background = Gtk::Image.new(:file => "../interfaces/IHM/fr/menus/ecranDeJeu.png")
    boardUi = Gtk::Table.new(1,3)

    # CONTROL PANEL
      @controlPanel = Gtk::Table.new(8,10)
      # CHRONO BUTTON
        self.addChrono(mode,time)
      # HYPOTHESIS BUTTONS
        newH = GameButton.new("blue","newHypothesis")
        @controlPanel.attach(newH.eb, 0, 1, 7, 8)
        applyH = GameButton.new("green","applyHypothesis")
        @controlPanel.attach(applyH.eb, 1, 2, 7, 8)
        cancelH = GameButton.new("red","cancelHypothesis")
        @controlPanel.attach(cancelH.eb, 2, 3, 7, 8)
      # HELP BUTTONS
        h1 = GameButton.new("aide1","help1")
        @controlPanel.attach(h1.eb, 4, 6, 7, 8)
        h2 = GameButton.new("aide2","help2")
        @controlPanel.attach(h2.eb, 6, 8, 7, 8)
        ud = GameButton.new("undo","undo")
        @controlPanel.attach(ud.eb, 0, 1, 8, 9)
        rd = GameButton.new("redo","redo")
        @controlPanel.attach(rd.eb, 1, 2, 8, 9)
        cl = GameButton.new("clear","clear")
        @controlPanel.attach(cl.eb, 2, 3, 8, 9)

    boardUi.attach(@gridBox, 0, 1, 0, 1)
    boardUi.attach(@controlPanel, 1, 2, 0, 1)
    boardUi.attach(@background, 0, 3, 0, 1)

    @win.add(boardUi)
    @win.show_all
    @win.signal_connect('delete_event') {
    	Gtk.main_quit
    	false
    }
  end

  def addChrono(mode, time)
    pauseScreen = PauseScreen.new
    l = Gtk::Label.new
    @chrono = Chronometre.new(l,mode,time)
    @chTable = Gtk::Table.new(4,7)
    img = Gtk::Image.new(:file => "../interfaces/IHM/fr/boutons/chronoPause.png")
    eb = Gtk::EventBox.new
    eb.signal_connect("button_press_event") do
      if(@chrono.paused?) then
        @chrono.start
        # @gridBox.remove(pauseScreen.table)
        # @gridBox.add(@grid)
        p 'clic sur PAUSE'
      else
        p 'clic sur PAUSE'
        @chrono.stop
        # @gridBox.remove(@grid)
        # @gridBox.add(pauseScreen.table)
      end
    end
    dM = Gtk::Image.new(:file => "../interfaces/IHM/fr/chiffres/digi0.png")
    uM = Gtk::Image.new(:file => "../interfaces/IHM/fr/chiffres/digi0.png")
    dS = Gtk::Image.new(:file => "../interfaces/IHM/fr/chiffres/digi0.png")
    uS = Gtk::Image.new(:file => "../interfaces/IHM/fr/chiffres/digi0.png")
    @chTable.attach(dM, 1, 2, 1, 2)
    @chTable.attach(uM, 2, 3, 1, 2)
    @chTable.attach(Gtk::Label.new("    "), 3, 4, 1, 2) # triche grossière mais j'ai pas mieux
    @chTable.attach(dS, 4, 5, 1, 2)
    @chTable.attach(uS, 5, 6, 1, 2)
    @chTable.attach(img,0,7,0,4)
    @chTable.attach(Gtk::Label.new("             "), 0, 1, 0, 1) # triche grossière mais j'ai pas mieux
    @chTable.attach(Gtk::Label.new("             "), 6, 7, 0, 1) # triche grossière mais j'ai pas mieux
    @chTable.attach(Gtk::Label.new("\n"), 0, 6, 3, 4)            # triche grossière mais j'ai pas mieux
    @chTable.attach(Gtk::Label.new("             "), 0, 7, 0, 1) # triche grossière mais j'ai pas mieux
    eb.add(@chTable)
    @controlPanel.attach(eb, 3, 4, 0, 1)
    @chronoDisplay = Thread.new {
      while(true)
        tab = @chrono.display4Ui
        dM.set_file("../interfaces/IHM/fr/chiffres/digi"+tab[0].to_s+".png")
        uM.set_file("../interfaces/IHM/fr/chiffres/digi"+tab[1].to_s+".png")
        dS.set_file("../interfaces/IHM/fr/chiffres/digi"+tab[2].to_s+".png")
        uS.set_file("../interfaces/IHM/fr/chiffres/digi"+tab[3].to_s+".png")
        sleep(1)
      end
    }
  end

  def start
    @chrono.start
    Gtk.main
  end

end
