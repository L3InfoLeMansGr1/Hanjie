#!/usr/bin/env ruby

require "gtk3"
require "./Ui/GridUi"
require "./Core/Game"
require "./Ui/Assets"

win = Gtk::Window.new
win.title = "test Game"
win.signal_connect('delete_event') {
	Gtk.main_quit
	false
}

rows = [[3,1,1],[3,1,1],[3,1,1],[3,4],[1,2],[1],[1,3],[3,2,2],[2,3,2],[2,1,1,2]];
cols = [[4,3],[4,3],[5,2],[2],[3],[4],[4],[5],[1,3],[4,3]];


game = Game.new(rows, cols)
assets = Assets.getInstance(rows.size)

grid = GridUi.new(game, assets)

image = Gtk::Image.new(file:"../interfaces/Ressources/1280x720/FR_fr/Menus/menuPrincipal.png")

mainGrid = Gtk::Table.new(1,1)
mainGrid.attach(grid.gtkObject, 0, 1, 0,1)
# (0..2).each {|i|
# 	(0..2).each {|j|
# 		if i == 1 && j == 1
# 		# elsif i != 0 || j != 0
# 		else
# 			# button = Gtk::Button.new(label: "button #{i*3+j}")
# 			# mainGrid.attach(button, j, j+1, i, i+1)
# 		end
# 	}
# }


# win.add(grid.gtkObject)
mainGrid.attach(image,0,1,0,1)
win.add(mainGrid)
# require "pry"
# win.pry
win.show_all
Gtk.main
