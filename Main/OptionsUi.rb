require 'rubygems'
require 'gtk3'

class OptionsUi

	attr_reader :gtkObject

	def initialize(parent)
		initGtkObject(parent)
	end

	def initGtkObject(parent)
		parent.changeBackground("menuOption")
		@gtkObject = Gtk::Box.new(:vertical)

		hboxResolution = Gtk::Box.new(:horizontal, 3)
		#labelResolution = Gtk::Label.new('Résolution d\'image : ') # a commenter avec background
		comboReso = Gtk::ComboBoxText.new
		comboReso.append_text "1024x576"
		comboReso.append_text "1280x720"
		comboReso.append_text "1440x810"
		#@hboxResolution.pack_start(labelResolution)  # a commenter avec background
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
		comboLangue.append_text "Anglais"
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
