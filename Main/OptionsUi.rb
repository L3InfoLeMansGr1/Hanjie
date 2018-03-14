require 'rubygems'
require 'gtk3'
require './Main/Options'

class OptionsUi

	@gtkObject
	@options

	attr_reader :gtkObject

	def initialize(parent)
		@options = Options.new
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		parent.changeBackground("menuOption")
		@gtkObject = Gtk::Box.new(:vertical)

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
		@gtkObject.pack_start(hboxResolution)

		hBoxCompletion = Gtk::Box.new(:horizontal, 3)
		#labelCompletion = Gtk::Label.new('Complétion automatique des blancs : ') # a commenter avec background
		checkCompletion = Gtk::CheckButton.new()
		checkCompletion.set_active(true)
		checkCompletion.set_name("checkCompletion")
		#@hBoxCompletion.pack_start(labelCompletion)  # a commenter avec background
		hBoxCompletion.pack_start(checkCompletion)
		@gtkObject.pack_start(hBoxCompletion)

		hBoxAide = Gtk::Box.new(:horizontal, 3)
		#labelAide = Gtk::Label.new('Aide à la vérification : ')# a commenter avec background
		checkAide = Gtk::CheckButton.new()
		checkAide.set_active(true)
		checkAide.set_name("checkAide")
		#@hBoxAide.pack_start(labelAide)# a commenter avec background
		hBoxAide.pack_start(checkAide)
		@gtkObject.pack_start(hBoxAide)

		hBoxLangue = Gtk::Box.new(:horizontal, 3)
		#labelLangue = Gtk::Label.new('Langue : ')# a commenter avec background
		comboLangue = Gtk::ComboBoxText.new
		comboLangue.append_text "Français"
		if @options.language == "FR_fr"
			comboLangue.set_active(0)
		end
		comboLangue.append_text "Anglais"
		if @options.language == "EN_en"
			comboLangue.set_active(1)
		end
		#@hBoxLangue.pack_start(labelLangue) # a commenter avec backgrounds
		hBoxLangue.pack_start(comboLangue)
		@gtkObject.pack_start(hBoxLangue)

		valider = Gtk::Button.new(:label => "valider", :use_underline => nil, :stock_id => nil)

		# valider.signal_connect('clicked') {
		# 	puts "valider click"
		# 	self.setLangue(comboLangue.active_text)
		# 	self.setResolution(comboReso.active_text)
		# }

		# checkAide.signal_connect("clicked")do
		# 	on_clicked @checkAide
		# end
    #
    #
		# checkCompletion.signal_connect("clicked") do |w|
		# 	on_clicked @checkCompletion
		# end
	end


end # Marqueur de fin de classe
