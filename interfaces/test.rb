require 'gtk3'

Gtk.init

window = Gtk::Window.new
window.signal_connect('destroy') {
   Gtk.main_quit
}

table = Gtk::Table.new(2,2)



imageBuf = GdkPixbuf::Pixbuf.new(:file => "./IHM/fr/fonds/noirGrille15x15.png")
# deprecated -> image1 = Gtk::Image.new bardejov
# all options
# image1 = Gtk::Image.new(:stock => nil, :icon_name => nil, :icon_set => nil,
# :gicon => nil, :file => nil, :pixbuf => bardejov, :animation => nil, :size => nil)
#Creation de l'event_box
b1 = Gtk::Image.new(:pixbuf => imageBuf)
table.attach(b1, 0, 1, 0, 1)
b2 = Gtk::Image.new(:pixbuf => imageBuf)
table.attach(b2, 0, 1, 1, 2)
b3 = Gtk::Image.new(:pixbuf => imageBuf)
table.attach(b3, 1, 2, 0, 1)
b4 = Gtk::Image.new(:pixbuf => imageBuf)
table.attach(b4, 1, 2, 1, 2)

window.add(table)

window.show_all

Gtk.main

print "Terminé\n"
