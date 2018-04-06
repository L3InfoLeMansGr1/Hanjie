class ClueLabel
	@@normal = "<span size=\"large\" color=\"black\">%{len}</span>"
	@@glowing = "<span size=\"large\" color=\"#008c17\">%{len}</span>"
	@len
	@gtkObject
	@glowing

	attr_reader :gtkObject

	def initialize(len)
		@len = len
		@gtkObject = Gtk::Label.new()
		self.normal()
		@gtkObject.set_use_markup true
	end

	def glow
		@glowing = true
		@gtkObject.set_markup @@glowing % {len:@len}
		show
	end

	def normal
		@glowing = false
		@gtkObject.set_markup @@normal % {len:@len}
		show
	end


	def glow?
		@glowing
	end

	def show
		@gtkObject.show_all
		self
	end

end
