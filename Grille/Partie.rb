load "../Grille/Grille.rb"
load "../Grille/Cellule.rb"
load "../Grille/Hypothese.rb"

class Partie

  @pileDecoups #Je sais pas
  @histoActions #Je sais pas
  @hypothese #Je sais pas
  @chronometre# le chronometre à voir


  def initialize(taille)
    grille = Grille.creer(taille,taille)
    0.upto(taille-1) do |i|
      0.upto(taille-1 ) do |j|
        grille.ajouterCellule(Cellule.creer(BLANC,true),i,j);
      end
    end
    @hypothese = Hypothese.creer(nil,grille)
  end

  def Partie.creer(taille)
    new(taille)
  end

  def getCurrentGrid()
    return @hypothese.grille
  end
end

partie = Partie.creer(20)
