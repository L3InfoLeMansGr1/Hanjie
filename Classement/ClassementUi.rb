#!/usr/bin/env ruby

require 'gtk3'
load './Classement/Classement_gen.rb'
load './Classement/Joueur_score.rb'



class ClassementUi

	@gtkObject

	attr_reader :gtkObject

  def initialize

		@gtkObject = Gtk::Box.new :vertical
		@gtkObject.set_name 'test'
		@cb = Gtk::ComboBoxText.new
		@cb.set_name 'comb'
		@cb.append_text 'Contre La Montre'
		@cb.append_text 'Mode Facile'
		@cb.append_text 'Mode Moyen'
		@cb.append_text 'Mode Difficile'
		@gtkObject.add(@cb)




	 store = Gtk::ListStore.new(String, Integer)
	 treeview = Gtk::TreeView.new(store)
	 setup_tree_view(treeview)

	 data = desereliseJoueurs

	 data.each_with_index do |e, i|
				 iter = store.append
			 store.set_value(iter, 0,  data[i].donneNom)
			 store.set_value(iter, 1, data[i].donneScore)
	 end


 	boxTree = Gtk::Box.new(:vertical, 10)
	boxTree.border_width = 10
	@gtkObject.pack_start(boxTree, true, true, 0)
	scrolled_win = Gtk::ScrolledWindow.new
	scrolled_win.add_with_viewport(treeview)
	scrolled_win.set_policy(:automatic,:automatic)
	boxTree.pack_start(scrolled_win, true, true, 0)

	separator = Gtk::Separator.new(:horizontal)
	@gtkObject.add(separator)
	separator.show
	fixed = Gtk::Fixed.new
	@gtkObject.add(fixed)
	button = Gtk::Button.new
	button.set_name 'b'
	button.set_size_request 167, 34
	fixed.put button, 800, 0
	@cb.signal_connect "changed" do |w, z|
		selectn(w, z, data,store)
	end
end
def on_changed sender, event
				puts sender.active_text
end

def ApplicationCss(style )
	provider = Gtk::CssProvider.new
	provider.load :data => style
		 styleContext = Gtk::StyleContext.new
			 styleContext.add_provider provider, GLib::MAXUINT
			 apply_css(@gtkObject, provider)
	 end




	 def apply_css(widget, provider)
			 widget.style_context.add_provider(provider, GLib::MAXUINT)
			 if widget.is_a?(Gtk::Container)
					 widget.each_all do |child|
							 apply_css(child, provider)
					 end
			 end
	 end


	def onDestroy
		puts "Fin de l'application"
		Gtk.main_quit
	end

	def setup_tree_view(treeview)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Nom", renderer,  :text => 0)
		treeview.append_column(column)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Score", renderer, :text => 1)
		treeview.append_column(column)
	end



	def selectn(w, z, data,store)
				on_changed w, z

					newdata1 = data.selectionneurMode(w.active_text)
					store.clear
					newdata1.each_with_index do |e, i|
						iter = store.append
						store.set_value(iter, 0, newdata1[i].donneNom )
						store.set_value(iter, 1, newdata1[i].donneScore)
				end
	end



	def desereliseJoueurs
		joueur = Joueur_score.new("Toto",1707111,"Mode Difficile")
		joueur1 = Joueur_score.new("Dave",1327413,"Contre La Montre")
		joueur2 = Joueur_score.new("Jacque",134564,"Mode Facile")
		joueur3 = Joueur_score.new("Pierrzre",4166,"Contre La Montre")
		joueur4 = Joueur_score.new("ssus",156436,"Mode Difficile")
		joueur5= Joueur_score.new("tata",1707111,"Mode Difficile")
		joueur6 = Joueur_score.new("Dazve",13213,"Contre La Montre")
		joueur7 = Joueur_score.new("dd",134564,"Mode Facile")
		joueur8 = Joueur_score.new("ddrfd",466,"Contre La Montre")
		joueur9 = Joueur_score.new("Pzaul",1564436,"Mode Difficile")
		joueur10= Joueur_score.new("Totezo",1707111,"Mode Moyen")
		joueur12 = Joueur_score.new("Jzdacque",1374564,"Mode Facile")
		joueur13 = Joueur_score.new("Piderre",466,"Contre La Montre")
		joueur14 = Joueur_score.new("Paudl",1564536,"Mode Difficile")
		joueur15 = Joueur_score.new("Toto",1707111,"Mode Difficile")
		joueur16 = Joueur_score.new("Ddfave",134213,"Contre La Montre");
		puts joueur.to_s
		puts joueur1.to_s
		puts joueur2.to_s
		puts joueur3.to_s
		puts joueur4.to_s
		general = Classement_gen.new
		general.push(joueur)
		general.push(joueur1)
		general.push(joueur2)
		general.push(joueur3)
		general.push(joueur4)
		general.push(joueur5)
		general.push(joueur6)
		general.push(joueur7)
		general.push(joueur8)
		general.push(joueur9)
		general.push(joueur10)
		general.push(joueur12)
		general.push(joueur13)
		general.push(joueur14)
		general.push(joueur15)
		general.push(joueur16)
		return(general.bubble_sort)
	end


	def onDestroy
		puts "Fin de l'application"
		Gtk.main_quit
	end

	def setup_tree_view(treeview)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Nom", renderer,  :text => 0)
		treeview.append_column(column)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Score", renderer, :text => 1)
		treeview.append_column(column)
	end

end
# c = ClassementUi.new()
# Gtk.main
