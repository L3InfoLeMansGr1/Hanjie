require "./Click"

class CellUi

	attr_reader :gtkButton, :row, :col
	def initialize(parent, row, col)
		@row = row
		@col = col
		@parent = parent

		@gtkButton = Gtk::Button.new(label:"r#{row}, c#{col}")

		releaseId = @gtkButton.signal_connect("button_release_event") { |_, event|
			@parent.last = self
			case event.button
			when Click::RIGHT
				self.rightReleased
			when Click::LEFT
				self.leftReleased
			end

			@parent.endDrag()
		}
		@gtkButton.signal_connect("button_press_event") { |_, event|
			@parent.first = self
			case event.button
			when Click::RIGHT
				self.rightClicked
			when Click::LEFT
				self.leftClicked
			end
			Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
			@gtkButton.signal_handler_block(releaseId)
			@gtkButton.signal_emit("button_release_event", Gdk::Event.new(Gdk::EventType::BUTTON_RELEASE))
			@gtkButton.signal_handler_unblock(releaseId)

		}
		@gtkButton.signal_connect("enter_notify_event") { |_, event|
			if @parent.first != nil
				@parent.last = self
				@parent.selection
			end
		}
	end

	def to_s
		"(r#{@row}, c#{@col})"
	end

	def say(msg)
		puts "Cell #{self}: #{msg}"
	end

	def rightClicked
		self.say("I have been rightClicked")
	end

	def leftClicked
		self.say("I have been leftClicked")
	end

	def rightReleased
		self.say("I have been rightReleased")
		@parent.rightClicked_draged
	end

	def leftReleased
		self.say("I have been leftReleased")
		@parent.leftClicked_draged
	end
end
