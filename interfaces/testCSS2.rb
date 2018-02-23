require 'gtk3'


LANGAGE = "fr"
class Accueil < Gtk::Builder

  def initialize
    super()
    self.add_from_file('./Accueil.glade')
    self['window1'].set_window_position Gtk::WindowPosition::CENTER
    self['window1'].signal_connect('destroy') { Gtk.main_quit }
    self['window1'].show_all
		# Creation d'une variable d'instance par composant glade
		 self.objects.each() { |p|
     		instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
		}

		self.connect_signals{ |handler|
			puts handler
			method(handler)
		}

    provider = Gtk::CssProvider.new
    provider.load (:data => 'GtkWindow{ background-image: url("./IHM/fr/menus/menuPrincipal.png")
		}')
    self['window1'].style_context.add_provider(provider, GLib::MAXUINT)

  end




  def afficherModesJeu
    puts "modes de jeu"
  end

  def afficherChargerPartie
    puts "charger partie"
  end

  def afficherOptions
  end

  def afficherClassement
  end

  def afficherApropos
  end

  #Bouton quitter
  def quitter()
    #puts("Je m'en vais")
    Gtk.main_quit
  end
end

builder = Accueil.new()
Gtk.main
