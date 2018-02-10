class Hypothese

  @hypotheseMere #l'hypothese mère dans l'arbre des hypotheses
  @grille #la grille de l'hypothese en cours

  attr_reader :grille

  def initialize(hm,g)
    @hypotheseMere = hm
    @grille = g
  end

  private_class_method :new
  def Hypothese.creer(hm,g)
    new(hm,g)
  end

end
