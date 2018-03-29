module Solver
	class StrategieUnify
		private_class_method :new
		def self.getState(cells)
			puts "not implemented"
		end
	end

	class StrategieUnifyAnyBlack < StrategieUnify

		def self.getState(cells)
			if (cells.any?{|c| c.state == :black})
				return :black
			end
			return :cross
		end
	end

	class StrategieUnifyAnyCross < StrategieUnify

		def self.getState(cells)
			if (cells.any?{|c| c.state == :cross})
				return :cross
			end
			return :black
		end
	end

	class StrategieUnifyMax < StrategieUnify

		def self.getState(cells)
			nBlack = cells.count{|c| c.state == :black}
			nCross = cells.size - nBlack
			if (nBlack > nCross)
				return :black
			end
			return :cross
		end
	end

end
