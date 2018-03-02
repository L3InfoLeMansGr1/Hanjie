require "gtk3"
require "./Ui/GameButton"

class PauseScreen
    @table

    attr_reader :table

    def initialize
      background = Gtk::Image.new(:file => "../interfaces/IHM/fr/menus/ecranDePause.png")
      @table = Gtk::Table.new(5,1)
      @table.attach(background,0,1,0,5)
    end

  end
