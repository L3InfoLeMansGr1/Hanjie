class Observable
	@observators
	def initialize
		@observators = []
	end

	def addObservator(observator)
		@observators << observator
	end

	def removeObservator(observator)
		@observators.remove(observator)
	end

	##
	# Send a notification with an array of data
	#
	def notifyObservators(*args)
		@observators.each{|obs| obs.update(args)}
	end
end
