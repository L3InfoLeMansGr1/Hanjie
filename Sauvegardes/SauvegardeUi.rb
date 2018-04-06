# encoding: UTF-8

require 'gtk3'
require File.dirname(__FILE__) + "/Sauvegardes.rb"
require File.dirname(__FILE__) + "/../Main/MenuItemUi"
require File.dirname(__FILE__) + "/../Main/MenuAssets"

class SauvegardeUi

	@gtkObject
	attr_reader :gtkObject

	def initialize(parent)
		 @gtkObject = Gtk::Box.new :vertical

		model = Gtk::ListStore.new(String)
		
		treeview = Gtk::TreeView.new(model)
		setup_tree_view(treeview)

		save = Sauvegardes.new("./Game/Core/Saves/","*.yml")
		data = save.chargerRepertoire
		data.each_with_index do |v|
		  iter = model.append
		  model.set_value(iter, 0, v)
		end

		box2 = Gtk::Box.new(:vertical, 10)
		box2.border_width = 10		
		@gtkObject.pack_start(box2, :expand => true, :fill => true, :padding => 0)

		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.add_with_viewport(treeview)
		scrolled_win.set_policy(:automatic,:automatic)
		box2.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)
		

		button = Gtk::Button.new(:label => "Charger")
		#button.set_flags(Gtk::Widget::CAN_FOCUS)

		button.signal_connect("clicked") do
			iter = treeview.selection.selected
			if(iter != nil)
				index = save.getIndex(model.get_value(iter,0)) #recuperation index
				infos = save.getInfos(index)
				parent.changeBackground("ecranDeJeu")
				if infos[0] == "Ranked"
					parent.display(RankedMode.new(nil,infos.join("&")))
				elsif infos[0] == "TimeTrial"
					parent.display(TimeTrialMode.new(infos.join("&")))
			end			
			else
				dialog = Gtk::Dialog.new("Message",$main_application_window,Gtk::DialogFlags::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::ResponseType::NONE ])
				dialog.signal_connect('response') { dialog.close }
				dialog.child.add(Gtk::Label.new("Veuillez selectionner une sauvegarde svp"))	
				dialog.show_all
			
			end
		end

		box2.pack_start(button, :expand => false, :fill => true, :padding => 0)


		button = Gtk::Button.new(:label =>"Supprimer")
		button.signal_connect("clicked") do
		  iter = treeview.selection.selected
		  index = save.getIndex(model.get_value(iter,0))#recuperation index
		  save.supprimer(index)
		  model.remove(iter)
		end
		box2.pack_start(button, :expand => false, :fill => true, :padding => 0)

		box2 = Gtk::Box.new(:vertical, 10)
		box2.border_width = 10
		@gtkObject.pack_start(box2,:expand => false, :fill => true, :padding => 0)

		bRetour = MenuItemUi.new(:back,MenuAssets.getInstance())
		bRetour.setOnClickEvent(Proc.new{
			parent.changeBackground("menuPrincipal")
			parent.display(parent.mainMenu)
		})
		box2.add(bRetour.gtkObject)
	end

	def setup_tree_view(treeview)
			renderer = Gtk::CellRendererText.new
			column = Gtk::TreeViewColumn.new("Liste des Sauvegardes", renderer,  :text => 0)
			treeview.append_column(column)
			
	end
end
