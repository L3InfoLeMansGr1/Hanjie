require 'gtk3'
load "./sauvegardes/SauvegardeUi.rb"
load "./Classement/ClassementUi.rb"
LANGAGE = "fr"
class Accueil < Gtk::Builder

	@pageCourante
	@boxModesAffichee
	@boxDifficulteAffichee

  def initialize
    super()
    self.add_from_file(__FILE__.sub(".rb",".glade"))
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

		css = 'GtkWindow{background-image: url("./interfaces/IHM/fr/menus/menuPrincipal.png")}'
		applicationCss(css)
		@pageCourante = @box1
		@boxModesAffichee = false
		@boxDifficulteAffichee = false
  end

	def applicationCss(style)
		@provider = Gtk::CssProvider.new
		@provider.load :data => style
		styleContext = Gtk::StyleContext.new
		styleContext.add_provider @provider, GLib::MAXUINT
		apply_css(@window1, @provider)
	end

	def apply_css(widget, provider)
		widget.style_context.add_provider(provider, GLib::MAXUINT)
		if widget.is_a?(Gtk::Container)
			widget.each_all do |child|
				apply_css(child, provider)
			end
		end
	end



  def afficherModesJeu
		if @boxModesAffichee
			@boxModes.hide
		else
			@boxModes.show
		end
		@boxDifficulte.hide
		@boxModesAffichee  = !@boxModesAffichee
  end

  def afficherChargerPartie
  	@window1.remove(@pageCourante)
		chargerPartie = SauvegardeUi.new(self)
		@pageCourante = chargerPartie.box
		@window1.add(@pageCourante)
		@window1.show_all
  end

  def afficherOptions
  end

  def afficherClassement
		@window1.remove(@pageCourante)
		classement = ClassementUi.new
		@pageCourante = classement.box
		@window1.add(@pageCourante)
		@window1.show_all
		afficherModesJeu
  end

  def afficherApropos
  end

  #Bouton quitter
  def quitter()
    Gtk.main_quit
  end

	def afficher()
		@window1.remove(@pageCourante)
		@pageCourante = @box1
		@window1.add(@pageCourante)
		@window1.show_all
		@boxModes.hide
		@boxDifficulte.hide
	end

	def lancer()
		@window1.show_all
		@boxModes.hide
		@boxDifficulte.hide
		Gtk.main
	end

	def lancerModeAventure
		puts "mode aventure"
	end

	def lancerModeCtlm
		puts "mode ctlm"
	end

	def lancerModeTutoriel
		puts "mode tuto"
	end

	def afficherNiveauDifficulte
		if @boxDifficulteAffichee
			@boxDifficulte.hide
		else
			@boxDifficulte.show
		end
		@boxDifficulteAffichee  = !@boxDifficulteAffichee
	end

	def lancerModeClasseFacile
		puts "mode facile"
	end

	def lancerModeClasseInter
		puts "mode intermediaire"
	end

	def lancerModeClasseDifficile
		puts "mode dificile"
	end
end
