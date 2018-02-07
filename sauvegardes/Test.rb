# encoding: UTF-8

# encoding: UTF-8

require 'gtk2'
load 'Sauvegardes.rb'

window = Gtk::Window.new("Sauvegardes")
window.border_width = 0

box1 = Gtk::VBox.new(false, 0)
window.add(box1)

box2 = Gtk::VBox.new(false, 5)
box2.border_width = 10
box1.pack_start(box2, true, true, 0)

scrolled_win = Gtk::ScrolledWindow.new
scrolled_win.set_policy(Gtk::POLICY_AUTOMATIC,Gtk::POLICY_AUTOMATIC)
box2.pack_start(scrolled_win, true, true, 0)



save = Sauvegardes.new("//info/etu/l3info/l3info037/tamer/","*.txt")
data = save.chargerRepertoire


model = Gtk::ListStore.new(String)
column = Gtk::TreeViewColumn.new("Liste des Sauvegardes", Gtk::CellRendererText.new, {:text => 0})


treeview = Gtk::TreeView.new(model)
treeview.append_column(column)
treeview.selection.set_mode(Gtk::SELECTION_SINGLE)
scrolled_win.add_with_viewport(treeview)

data.each do |v|
  iter = model.append
  iter[0] =  v
end

button = Gtk::Button.new("Charger")
button.set_flags(Gtk::Widget::CAN_FOCUS)

button.signal_connect("clicked") do
  iter = treeview.selection.selected
  index = save.getIndex(model.get_value(iter,0)) #recuperation index
  save.charger(index)
end

box2.pack_start(button, false, true, 0)


button = Gtk::Button.new("Supprimer")
button.set_flags(Gtk::Widget::CAN_FOCUS)
button.signal_connect("clicked") do
  iter = treeview.selection.selected
  
  index = save.getIndex(model.get_value(iter,0))#recuperation index
  save.supprimer(index)
  model.remove(iter)
end
box2.pack_start(button, false, true, 0)



box2 = Gtk::VBox.new(false, 10)
box2.border_width = 10
box1.pack_start(box2, false, true, 0)

button = Gtk::Button.new("Retour")
button.signal_connect("clicked") do
  Gtk.main_quit
end



box2.pack_start(button, true, true, 0)
button.set_flags(Gtk::Widget::CAN_DEFAULT)


window.set_default_size(3000, 3000)
window.show_all

Gtk.main