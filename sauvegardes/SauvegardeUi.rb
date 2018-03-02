# encoding: UTF-8

require 'gtk3'
load './sauvegardes/Sauvegardes.rb'

class SauvegardeUi

	@box
	attr_reader :box

	def initialize(parent)
		@box = Gtk::Box.new(:vertical,0)

		box2 = Gtk::Box.new(:vertical, 5)
		box2.border_width = 10
		@box.pack_start(box2, :expand => true, :fill => true, :padding => 0)

		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.set_policy(Gtk::PolicyType::AUTOMATIC,Gtk::PolicyType::AUTOMATIC)
		box2.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)



		save = Sauvegardes.new("./Saves/","*.txt")
		data = save.chargerRepertoire


		model = Gtk::ListStore.new(String)
		column = Gtk::TreeViewColumn.new("Liste des Sauvegardes", Gtk::CellRendererText.new, {:text => 0})


		treeview = Gtk::TreeView.new(model)
		treeview.append_column(column)
		treeview.selection.set_mode(Gtk::SelectionMode::SINGLE)
		scrolled_win.add_with_viewport(treeview)

		data.each do |v|
		  iter = model.append
		  iter[0] =  v
		end

		button = Gtk::Button.new(:label => "Charger")
		#button.set_flags(Gtk::Widget::CAN_FOCUS)

		button.signal_connect("clicked") do
		  iter = treeview.selection.selected
		  index = save.getIndex(model.get_value(iter,0)) #recuperation index
		  save.charger(index)
		end

		box2.pack_start(button, :expand => false, :fill => true, :padding => 0)


		button = Gtk::Button.new(:label =>"Supprimer")
		#button.set_flags(Gtk::Widget::CAN_FOCUS)
		button.signal_connect("clicked") do
		  iter = treeview.selection.selected
		  index = save.getIndex(model.get_value(iter,0))#recuperation index
		  save.supprimer(index)
		  model.remove(iter)
		end
		box2.pack_start(button, :expand => false, :fill => true, :padding => 0)

		box2 = Gtk::Box.new(:vertical, 10)
		box2.border_width = 10
		@box.pack_start(box2,:expand => false, :fill => true, :padding => 0)

		button = Gtk::Button.new(:label =>"Retour")
		button.signal_connect("clicked") do
		  #Gtk.main_quit
			parent.afficher()
		end
		box2.pack_start(button, :expand => true, :fill => true, :padding => 0)
		#button.set_flags(Gtk::Widget::CAN_DEFAULT)
	end
end
