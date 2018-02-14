class Hypothese

  @hypotheseMere
  @grille #la grille de l'hypothese en cours

  attr_reader :grille, :hypotheseMere

  def initialize(hm,g)
    @hypotheseMere = hm
    @grille = g
  end

  private_class_method :new
  def Hypothese.creer(hm,g)
    new(hm,g)
  end

  def creerFille()
    grille = Grille.copier(@grille)
    return Hypothese.creer(self,grille)
  end

end
