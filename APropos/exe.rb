require "gtk3"

width = 1280
height = 720

window = Gtk::Window.new
window.set_title('À propos')
window.signal_connect('destroy') { Gtk.main_quit }
window.set_default_size(width,height)

dev = ""

# Read files
filedev = File.new("dev.txt","r")
while (line = filedev.gets)
    dev += line
end
filedev.close


# Set TextView
bufdev = Gtk::TextBuffer.new()
bufdev.set_text(dev)
view1 = Gtk::TextView.new(bufdev)
view1.cursor_visible=(false)
view1.editable=(false)
view1.set_pixels_above_lines(10)

#Set Button
button1 = Gtk::Button.new(:label => "Retour")
button1.signal_connect("button_release_event"){Gtk.main_quit}

#Set Box
vbox = Gtk::Box.new(:vertical)
vbox.pack_start(view1)
vbox.pack_end(button1)
window.modify_bg(STATE_NORMAL,Gdk::Color.new(0,0,0))

window.add(vbox)
window.show_all
Gtk.main



