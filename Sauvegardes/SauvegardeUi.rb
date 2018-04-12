# encoding: UTF-8

require 'gtk3'
require File.dirname(__FILE__) + "/Sauvegardes.rb"
require File.dirname(__FILE__) + "/../Main/MenuItemUi"
require File.dirname(__FILE__) + "/../Main/MenuAssets"

class SauvegardeUi

	@gtkObject
	@assets

	attr_reader :gtkObject


	##
	# Creates a new Sauvegardes menu.
	# * *Arguments* :
	#   - +Parent+ -> The parent menu of this one.

	def initialize(parent)
		@assets = MenuAssets.getInstance
		@gtkObject = Gtk::Box.new :vertical

		model = Gtk::ListStore.new(String)

		@treeview = Gtk::TreeView.new(model)
		setup_tree_view(@treeview)

		save = Sauvegardes.new("./Game/Core/Saves/","*.yml")

		data = save.chargerRepertoire

		# swapped = true
		# while swapped do
		# 	swapped = false
		# 	0.upto(data.size-2) do |i|
		# 		if (Date.parse(data[i].split("&")[2][0...10]) <=> Date.parse(data[i].split("&")[2][0...10]))<0
		# 			data[i], data[i+1] = data[i+1], data[i]
		# 			swapped = true
		# 		end
		# 	end
		# end

		data.sort!{|n, m|
			n.split("&").last <=> m.split("&").last
		}



		data.each_with_index do |v|
		  iter = model.append
		  model.set_value(iter, 0, v)
		end

		box2 = Gtk::Box.new(:vertical, 10)
		box2.border_width = 10
		@gtkObject.pack_start(box2, :expand => true, :fill => true, :padding => 0)

		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.add_with_viewport(@treeview)
		scrolled_win.set_policy(:automatic,:automatic)
		box2.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)


		# box2 = Gtk::Box.new :horizontal
		# box2.border_width = 10

		box2 = Gtk::ButtonBox.new :horizontal
		box2.layout = :center

		bLoad = MenuItemUi.new(:load, @assets)
		bLoad.setOnClickEvent(Proc.new{
			iter = @treeview.selection.selected
			if(iter != nil)
				index = save.getIndex(model.get_value(iter,0)) #recuperation index
				infos = save.getInfos(index)
				parent.changeBackground("ecranDeJeu")
				if infos[0] == "Ranked"
					parent.display(RankedMode.new(nil,parent,infos.join("&")))
				elsif infos[0] == "TimeTrial"
					path = File.dirname(__FILE__) + "/../Game/Core/Saves/"+infos.join("&")
					data = YAML.load_file(path)
					nbGrids = data["nbGames"]
					difficulty = :easy
					if nbGrids > 5
						difficulty = :intermediate
					elsif nbGrids > 10
						difficulty = :hard
					end
					parent.display(TimeTrialMode.new(parent,infos.join("&"),difficulty,nbGrids ))
				end
			else
				dialog = Gtk::Dialog.new("Message",$main_application_window,Gtk::DialogFlags::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::ResponseType::NONE ])
				dialog.signal_connect('response') { dialog.close }
					if @assets.language == "FR_fr"
						dialog.child.add(Gtk::Label.new("\n\n\t Veuillez selectionner une sauvegarde à charger.\t\n\n"))
					else
						dialog.child.add(Gtk::Label.new("\n\n\t Please select a save file to load.\t\n\n"))
					end
				dialog.show_all
			end
		})

		box2.add(bLoad.gtkObject)

		bDelete = MenuItemUi.new(:delete, @assets)
		bDelete.setOnClickEvent(Proc.new{
		  iter = @treeview.selection.selected

		if(iter != nil)
		  index = save.getIndex(model.get_value(iter,0))#recuperation index
		  save.supprimer(index)
		  model.remove(iter)
		else
		dialog = Gtk::Dialog.new("Message",$main_application_window,Gtk::DialogFlags::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::ResponseType::NONE ])
		dialog.signal_connect('response') { dialog.close }
			if @assets.language == "FR_fr"
				dialog.child.add(Gtk::Label.new("\n\n\t Veuillez selectionner une sauvegarde à supprimer.\t\n\n"))
			else
				dialog.child.add(Gtk::Label.new("\n\n\t Please select a save file to delete.\t\n\n"))
			end
		dialog.show_all
		end




		})
		box2.add(bDelete.gtkObject)

		# @gtkObject.pack_start(box2, :expand => false, :fill => true, :padding => 0)
		# box2 = Gtk::Box.new(:vertical, 10)
		# box2.border_width = 10
		# @gtkObject.pack_start(box2, :expand => false, :fill => true, :padding => 0)

		bRetour = MenuItemUi.new(:back,@assets)
		bRetour.setOnClickEvent(Proc.new{
			parent.changeBackground("menuPrincipal")
			parent.display(parent.mainMenu)
		})
		box2.add(bRetour.gtkObject)
		@gtkObject.pack_start(box2, :expand => false, :fill => true, :padding => 0)
	end


	##
	# Setup a GTK treeview with the saves.
	# * *Arguments* :
	#   - +treeview+ -> A Gtk treeview.


	def setup_tree_view(treeview)
			renderer = Gtk::CellRendererText.new
			column = Gtk::TreeViewColumn.new("Liste des Sauvegardes", renderer,  :text => 0)
			treeview.append_column(column)

	end
end
