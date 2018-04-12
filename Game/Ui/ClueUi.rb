require File.dirname(__FILE__) + "/ClueLabel"

class ClueUi
	@blocks
	@index
	@gtkObject
	@labels

	@state

	attr_reader :gtkObject
	def initialize(orientation, blocks, index)
		# blocks = [0] if blocks.size == 0
		@blocks = blocks.size == 0 ? [0] : blocks
		@index = index

		@state = :clue

		@gtkSum = Gtk::Label.new()
		@gtkSum.set_use_markup(true)
		@gtkSum.set_markup("<span size=\"large\">#{(@blocks.sum + @blocks.size - 1)}</span>")
		@gtkBoxClues = Gtk::Box.new(orientation)
		@labels = @blocks.reverse.map { |length|
			label = ClueLabel.new(length)
			@gtkBoxClues.pack_end(label.gtkObject, expand:false, fill:false, padding:3)
			label
		}.reverse
		@gtkObject = Gtk::EventBox.new()
		@gtkMainBox = Gtk::Box.new(orientation == :vertical ? :horizontal : :vertical)
		@gtkObject.add(@gtkMainBox)
		changeToClue()

		@gtkObject.signal_connect("button_press_event") { |_, event|
			swap()
		}

		glow_all if blocks.size == 0
	end

	# def labelText

	def swap
		removeChild()
		if @state == :clue
			changeToSum
		else
			changeToClue
		end
		show
	end

	def changeToSum
		# rgba(255, 124, 4, 1)
		@gtkMainBox.override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(255.0/255, 124.0/255, 4.0/255, 1))
		# @gtkMainBox.override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(12.0/255, 200.0/255, 2.0/255, 0.6))
		@gtkMainBox.add(@gtkSum)
		@state = :sum
	end

	def changeToClue
		@gtkMainBox.override_background_color(Gtk::StateFlags::NORMAL, Gdk::RGBA.new(1,1,1,0.6))
		@gtkMainBox.add(@gtkBoxClues)
		@state = :clue
	end

	def removeChild
		@gtkMainBox.each{|child|
			@gtkMainBox.remove(child)
		}
	end

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

	def glow_all
		@labels.map(&:glow)
	end

	def show
		@gtkObject.show_all
	end

end
