require File.dirname(__FILE__) + "/CellAssets"

class Preview
	@gtkObject
	@game
	@surface
	@size
	@assets

	attr_reader :gtkObject

	def initialize(game)
		@game = game
		@gtkObject = Gtk::DrawingArea.new
		@assets = CellAssets.getInstance(game.nRow)
		if @assets.resolution == "1440x810"
			@size = 140
		elsif @assets.resolution == "1280x720"
			@size = 124
		else
			@size = 99
		end

		@gtkObject.set_size_request(@size, @size)

		@gtkObject.signal_connect "draw" do |_widget, cr|
      onDrawSignal(cr)
    end

    @gtkObject.signal_connect "configure-event" do |widget|
      onConfigureEventSignal(widget)
		end
	end

	def onDrawSignal(cr)
    # Redraw the screen from the
    cr.set_source(@surface, 0, 0)
    cr.paint
    false
	end

	def onConfigureEventSignal(da)
    @surface.destroy if @surface

    @surface = da.window.create_similar_surface(Cairo::CONTENT_COLOR,
                                                da.allocated_width,
                                                da.allocated_height)
    # initialize the surface to white
    cr = Cairo::Context.new(@surface)
    cr.set_source_rgba(1, 1, 1, 1)
    cr.paint
    cr.destroy
    # we have handled the configure event, no need to further processing
    true
	end

	def update(row, col, asset)
		return false unless @surface
		cr = Cairo::Context.new(@surface)
	  checkWidth = @size/@game.nCol
		checkHeight = @size/@game.nRow
		i = checkWidth * row
		j = checkHeight * col
		if asset == :black then
			cr.set_source_rgba(0, 0, 0, 1)
		else
			cr.set_source_rgba(1, 1, 1, 1)
		end
		cr.rectangle(j, i, checkWidth, checkHeight)
		cr.fill
		cr.destroy
		@gtkObject.queue_draw
 end

end
