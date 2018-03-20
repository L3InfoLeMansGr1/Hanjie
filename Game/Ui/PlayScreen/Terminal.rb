require "gtk3"
# require File.dirname(__FILE__) + "/../GridUi" ?
require File.dirname(__FILE__) + "/../../../Main/MenuAssets"
require File.dirname(__FILE__) + "/TerminalInput"

class Terminal
  @grid
  @gtkObject
  @assets

  @labelYes
  @labelNno
  @labelBack

  @textYes
  @textNo
  @textBack
  @text1
  @text2
  @text3

  @currentText

  @tries

  attr_reader :gtkObject

  def initialize(grid)
    @grid = grid
    @assets = MenuAssets.getInstance
    @tries = 3
    @gtkObject = Gtk::Table.new(4,1)

    if(@assets.language=="FR_fr") then
      @textYes = "oui"
      @textNo = "non"
      @textBack = "retour"
      @text1 = "verifier La Grille ?"
      @text2 = "Erreur détectée, corriger ? restant : "
      @text3 = "Acune Erreur détectée"
    else
      if (@assets.language=="EN_en") then
        @textYes = "yes"
        @textNo = "no"
        @textBack = "back"
        @text1 = "Verify Grid ?"
        @text2 = "Error detected, rectify ? left: "
        @text3 = "No Error detected"
      end
    end

    @labelYes = TerminalInput.new(@textYes)
    @labelNo = TerminalInput.new(@textNo)
    @labelBack = TerminalInput.new(@textBack)

    pathText = File.dirname(__FILE__) + "/../../../Assets/" + @assets.resolution + "/" + @assets.language + "/Texts/"
    @currentText = Gtk::Label.new(@text1)

    @gtkObject.attach(@currentText,0,1,0,1)
    @gtkObject.attach(@labelYes.gtkObject,0,1,1,2)
    @gtkObject.attach(@labelNo.gtkObject,0,1,2,3)
    @gtkObject.attach(@labelBack.gtkObject,0,1,3,4)

    self.goState1

  end

  def goState1
    @currentText.set_text(@text1)
    @labelNo.hide
    @labelBack.hide

    @labelYes.gtkObject.signal_connect("button_press_event") do
      if true then #y a dé fotes ?
        self.goState2
      else
        self.goState3
      end
    end
  end

  def goState2
    @currentText.set_text(@text2+@tries.to_s)
    @currentText.set_text(@text2)
    @labelNo.show

    @labelYes.gtkObject.signal_connect("button_press_event") do
      # DO CORRECTION !
      @tries -= 1
      self.goSate1
    end

    @labelNo.gtkObject.signal_connect("button_press_event") do
      self.goState1
    end
  end

  def goState3
    @currentText.set_text(@text3)
    @labelYes.hide
    @labelNo.hide
    @labelBack.show

    @labelNo.gtkObject.signal_connect("button_press_event") do
      self.goState1
    end
  end

end
