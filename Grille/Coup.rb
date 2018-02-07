class Coup

  #@param @cellulesModifies , les cellules mofiées par le coup

  @cellulesModifiés

  def initialize
    @cellulesModifiés = new Array()
  end

  def ajouter(cellule)
    @cellulesModifiés.push(cellule)
  end
end
