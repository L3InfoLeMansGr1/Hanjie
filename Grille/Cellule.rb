BLANC = 1
NOIR = 2
CROIX = 3


class Cellule

	#param @etat int
	# 1 = blanc, 2 = noir, 3 = croix
	#@param droit boolean

	@etat
	@droit

	attr_accessor :etat, :droit
	private_class_method :new

    def initialize(etat, droit)
        @etat = etat
        @droit = droit
    end


    def Cellule.creer(etat, droit)
    	new(etat, droit)
    end


    def clicDroit()
    	if(@etat == 1)
    		@etat = 3
    	elsif(@etat == 2)
    		@etat = 2
    	else
    		@etat = 1
    	end
    end

    def clicGauche()
    	if(@etat == 1)
			@etat = 2
		elsif(@etat == 2)
			@etat = 1
		else
			@etat = 3
		end
    end

    def Cellule.copier(cellule)
    	return new(cellule.etat,cellule.droit)
    end

    def to_s
    	"etat = #{@etat}, droit =  #{@droit}"
    end

		def reset
			@etat = 1
		end

end
