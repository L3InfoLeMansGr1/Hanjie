require "gtk3"

class GameButton
  @img
  @eb
  @doOnclick

  attr_reader :eb

  def initialize(name,clickMethod)
    @img = Gtk::Image.new(:file => "../interfaces/IHM/fr/boutons/"+name+"Off.png")
    @eb = Gtk::EventBox.new
    @doOnclick = clickMethod
    @eb.add(@img)

    @eb.signal_connect("enter_notify_event") do
      @img.set_file("../interfaces/IHM/fr/boutons/"+name+"On.png")
    end
    @eb.signal_connect("leave_notify_event") do
      @img.set_file("../interfaces/IHM/fr/boutons/"+name+"Off.png")
    end
    @eb.signal_connect("button_press_event") do
      p 'clic sur '+name
      # CLICKMETHOD CALLING
    end

  end

end
