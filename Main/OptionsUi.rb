# require 'rubygems'
require 'gtk3'
require File.dirname(__FILE__) + "/Options"
require File.dirname(__FILE__) + "/MenuAssets"

class OptionsUi

	@gtkObject
	@options
	@assets


	LANGUAGE = {
		"Français" => "FR_fr",
		"English" => "EN_en"
	}

	COLORS = {
		"FR_fr" => ["Bleu","Rouge","Vert","Jaune","Violet"],
		"EN_en"=> ["Blue","Red","Green","Yellow","Purple"]
	}

	attr_reader :gtkObject

	def initialize(parent)
		@options = Options.new
		@assets=MenuAssets.getInstance
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		parent.changeBackground("menuOption")
		@gtkObject = Gtk::Box.new(:horizontal)
		@gtkObject.homogeneous=(true)
		@gtkObject.add(Gtk::Box.new(:vertical))
		milieu = Gtk::Box.new(:vertical)
		@gtkObject.add(milieu)
		box = Gtk::Box.new(:vertical)
		droite = Gtk::Box.new(:vertical)

		if (@assets.resolution == "1440x810")
			droite.spacing= 25
			box.pack_start(droite,:padding => 250)
		elsif(@assets.resolution == "1280x720")
			droite.spacing= 23
			box.pack_start(droite,:padding => 215)
		elsif(@assets.resolution == "1024x576")
			droite.spacing= 15
			box.pack_start(droite,:padding => 165)
		end

		@gtkObject.pack_start(box)

		hboxResolution = Gtk::Box.new(:horizontal, 3)
		#labelResolution = Gtk::Label.new('Résolution d\'image : ') # a commenter avec background
		comboReso = Gtk::ComboBoxText.new
		resolutions = ["1024x576","1280x720","1440x810"]
		resolutions.each_with_index{ |res,i|
			comboReso.append_text(resolutions[i])
			if res == @options.resolution
				comboReso.set_active(i)
			end
		}
		#@hboxResolution.pack_start(labelResolution)  # a commenter avec background
		hboxResolution.pack_start(comboReso)
		droite.pack_start(hboxResolution)

		hBoxCompletion = Gtk::Box.new(:horizontal, 3)
		#labelCompletion = Gtk::Label.new('Complétion automatique des blancs : ') # a commenter avec background
		checkCompletion = Gtk::CheckButton.new()
		checkCompletion.set_active(true)
		checkCompletion.set_name("checkCompletion")
		#@hBoxCompletion.pack_start(labelCompletion)  # a commenter avec background
		hBoxCompletion.pack_start(checkCompletion)
		droite.pack_start(hBoxCompletion)

		hBoxAide = Gtk::Box.new(:horizontal, 3)
		#labelAide = Gtk::Label.new('Aide à la vérification : ')# a commenter avec background
		checkAide = Gtk::CheckButton.new()
		checkAide.set_active(true)
		checkAide.set_name("checkAide")
		#@hBoxAide.pack_start(labelAide)# a commenter avec background
		hBoxAide.pack_start(checkAide)
		droite.pack_start(hBoxAide)

		hBoxLangue = Gtk::Box.new(:horizontal, 3)
		#labelLangue = Gtk::Label.new('Langue : ')# a commenter avec background
		comboLangue = Gtk::ComboBoxText.new
		comboLangue.append_text "Français"
		if @options.language == "FR_fr"
			comboLangue.set_active(0)
		end
		comboLangue.append_text "English"
		if @options.language == "EN_en"
			comboLangue.set_active(1)
		end
		#@hBoxLangue.pack_start(labelLangue) # a commenter avec backgrounds
		hBoxLangue.pack_start(comboLangue)
		droite.pack_start(hBoxLangue)

		hboxColor = Gtk::Box.new(:horizontal, 3)
		comboColor = Gtk::ComboBoxText.new
		colors = COLORS[@options.language]
		colors.each_with_index{ |res,i|
			comboColor.append_text(colors[i])
			if COLORS["EN_en"][i] == @options.color
				comboColor.set_active(i)
			end
		}
		#@hboxResolution.pack_start(labelResolution)  # a commenter avec background
		hboxColor.pack_start(comboColor)
		droite.pack_start(hboxColor)

		bas = Gtk::Box.new(:horizontal)
		#bas.spacing = 10
		valider = Gtk::Button.new(:label => "valider")
		retour = MenuItemUi.new(:back,@assets)
		retour.setOnClickEvent(Proc.new{
			parent.changeBackground("menuPrincipal")
			parent.display(parent.mainMenu)
		})
		bas.pack_start(valider,:expand => true, :fill => true)
		bas.pack_start(retour.gtkObject,:expand => true, :fill => true)
		milieu.pack_end(bas, :padding => 100)

		valider.signal_connect("clicked") do
			@options.setResolution(comboReso.active_text)
			@options.setLanguage(LANGUAGE[comboLangue.active_text])
			@options.setColor(COLORS["EN_en"][comboColor.active])
			@options.submit()
			parent.display(OptionsUi.new(parent))
			dialog = Gtk::Dialog.new("Message",
                             $main_application_window,
                             Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

    										 # Ensure that the dialog box is destroyed when the user responds.
    	dialog.signal_connect('response') {
				Gtk.main_quit
			}

    	# Add the message in a label, and show everything we've added to the dialog.
			if @options.language == "FR_fr"
    		dialog.child.add(Gtk::Label.new("Redemarrez le jeu afin d'appliquer vos changements"))
			else
				dialog.child.add(Gtk::Label.new("Restart the game in order to apply your changes"))
			end
    	dialog.show_all
		end

		parent.show_all
	end


end # Marqueur de fin de classe
