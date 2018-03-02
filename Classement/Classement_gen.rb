##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Sat Feb 17 20:46:47 CET 2018
#
load './Classement/Joueur_score.rb'


class Classement_gen < Array
	def initialize()
		super
	end

	def chaine
		res = []
		self.each_index do |i|
			res[i] = self[i].donneNom
		end
		return res
	end

	def bubble_sort
		return self if self.size <= 1
		swapped = true
		while swapped do
			swapped = false
			0.upto(self.size-2) do |i|
				if self[i].donneScore < self[i+1].donneScore
					self[i], self[i+1] = self[i+1], self[i]
					swapped = true
				end
			end
		end
	  	self
	end

	def selectionneurMode(unMode)
		res=[]
		0.upto(self.size-1) do |i|
			if self[i].donneMode == unMode
				res.push(self[i])
			end
		end
		res
	end
end
