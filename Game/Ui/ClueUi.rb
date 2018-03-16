require File.dirname(__FILE__) + "/ClueLabel"

class ClueUi
	@blocks
	@index
	@gtkObject
	@labels
	@normal
	@glowing

	attr_reader :gtkObject
	def initialize(orientation, blocks, index)
		blocks = [0] if blocks.size == 0
		@blocks = blocks
		@index = index



		gtkBox = Gtk::Box.new(orientation)
		@labels = blocks.reverse.map { |length|
			label = ClueLabel.new(length)
			gtkBox.pack_end(label.gtkObject, expand:false, fill:false, padding:3)
			label
		}.reverse
		@gtkObject = Gtk::Box.new(orientation == :vertical ? :horizontal : :vertical)

		@gtkObject.override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(1,1,1,1))
		# require "pry"
		# Gdk.pry
		# @gtkObject.pry
		# @gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end

	# def labelText

	def updateGlowingClue(blocks)
		@labels.each_with_index {|lbl, i|
			incl = blocks.include?(i)
			glow = lbl.glow?

			if  incl && !glow
				lbl.glow
			elsif !incl && glow
				lbl.normal
			end
		}
	end

	def show
		@gtkObject.show_all
	end

end
