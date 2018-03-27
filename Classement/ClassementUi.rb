require 'gtk3'
require File.dirname(__FILE__) + "/Classement_gen"
require File.dirname(__FILE__) + "/Joueur_score"
require File.dirname(__FILE__) + "/../Main/MenuItemUi"
require File.dirname(__FILE__) + "/../Main/MenuAssets"

class ClassementUi

	@gtkObject

	attr_reader :gtkObject

  def initialize(parent)
    @gtkObject = Gtk::Box.new :vertical
    @gtkObject.set_name 'test'
		@cb = Gtk::ComboBoxText.new
    @cb.append_text 'Général'
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
   		store.set_value(iter, 0, data[i].donneNom)
    	store.set_value(iter, 1, data[i].donneScore)
		end
		boxTree = Gtk::Box.new(:vertical, 10)
		boxTree.border_width = 10
		@gtkObject.pack_start(boxTree,:expand => true, :fill => true, :padding => 0)

		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.add_with_viewport(treeview)
		scrolled_win.set_policy(:automatic,:automatic)
		boxTree.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)

		separator = Gtk::Separator.new(:horizontal)
		@gtkObject.pack_start(separator, :expand => false, :fill => true, :padding => 0)
		separator.show


		bRetour = MenuItemUi.new(:back,MenuAssets.getInstance())
		bRetour.setOnClickEvent(Proc.new{
			parent.changeBackground("menuPrincipal")
			parent.display(parent.mainMenu)
		})
		@gtkObject.add(bRetour.gtkObject)

		@cb.signal_connect "changed" do |w, z|
      selectn(w,z,data,store)
		end
	end



	def on_changed sender, event
	        puts sender.active_text
	end

	def setup_tree_view(treeview)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Nom", renderer,  :text => 0)
		treeview.append_column(column)
		renderer = Gtk::CellRendererText.new
		column   = Gtk::TreeViewColumn.new("Score", renderer, :text => 1)
		treeview.append_column(column)
	end

	def selectionneurMode(tab,unMode)
		res = Array.new
		tab.each do |joueur|
			if joueur.donneMode == unMode
				res.push(joueur)
			end

		end
		res
	end


	def selectn(w, z, data,store)
		on_changed w, z

	  if(w.active_text == 'Général')
	  	newdata1 = data
	  else
	  	newdata1 = selectionneurMode(data , w.active_text)
	  end
	  store.clear


	  newdata1.each_with_index do |e, i|
			iter = store.append
			store.set_value(iter, 0, newdata1[i].donneNom )
			store.set_value(iter, 1, newdata1[i].donneScore)
		end
	end


	def desereliseJoueurs
		tab = Classement_gen.instance

		tab.ajouteJoueur(Joueur_score.new("First",5999999,"Mode Difficile"))

		tab1 = Array.new()
		tab1= tab.deserealiseJoueurs()
	end

end
