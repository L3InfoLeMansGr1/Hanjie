load 'Classement_gen.rb'
load 'Joueur_score.rb'



joueur = Joueur_score.new("Toto",1707111,"Difficile")
joueur1 = Joueur_score.new("Dave",13213,"Facile")
joueur2 = Joueur_score.new("Jacque",134564,"Moyen")
joueur3 = Joueur_score.new("Pierre",466,"CLM")
joueur4 = Joueur_score.new("Paul",156436,"Difficile")

puts joueur.donneNom
puts joueur1.donneNom
puts joueur2.donneNom
puts joueur3.donneNom
puts joueur4.donneNom

general = Classement_gen.new

general.push(joueur)
general.push(joueur2)
general.push(joueur3)
general.push(joueur4)
general.push(joueur1)

p "liste score"
puts general.chaine
general.bubble_sort

p (general.selectionneurMode("Difficile")).to_s
