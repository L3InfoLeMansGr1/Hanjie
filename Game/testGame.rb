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
assets = Assets.new(rows.size)

grid = GridUi.new(game, assets)


win.add(grid.gtkGrid)
win.show_all
Gtk.main
