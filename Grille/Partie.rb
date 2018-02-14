load "../Grille/Grille.rb"
load "../Grille/Cellule.rb"
load "../Grille/Hypothese.rb"

class Partie

  @pileDecoups #Je sais pas
  @histoActions #Je sais pas

  @hypothese #Reference vers l'hypothese la plus recente, cette hypothese connait son géniteur
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

  def getCellAt(x,y)
    return @hypothese.grille.getCellule(x,y)
  end

  def getCurrentGrid()
    return @hypothese.grille
  end


  def newHyp
    @hypothese = @hypothese.creerFille()
  end

  def cancelHyp
    @hypothese = @hypothese.hypotheseMere
  end
end

#partie = Partie.creer(20)
