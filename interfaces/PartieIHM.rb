require 'gtk3'
load '../Constants.rb'
load '../Grille/Partie.rb'


LANGAGE = "fr"
class PartieIHM < Gtk::Builder

  @taille #Taille de la grille
  @mode #mode de jeu
  @chrono #le chronometre
  @partie #la partie

  def initialize(taille,mode)
    #Partie interface
    super()
    self.add_from_file(__FILE__.sub(".rb",".glade"))
    self['window1'].set_window_position Gtk::WindowPosition::CENTER
    #self['window1'].set_default_size(1920,800)
    self['window1'].signal_connect('destroy') { Gtk.main_quit }
    self['window1'].show_all
		# Creation d'une variable d'instance par composant glade
		 self.objects.each() { |p|
     		instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
		}

		self.connect_signals{ |handler|
			puts handler
			method(handler)
		}

    provider = Gtk::CssProvider.new
    provider.load :path => "./Partie.css"
    self['window1'].style_context.add_provider(provider, GLib::MAXUINT)

    #Generation de la partie
    #Verification de la solution dans cette classe, a voir si on ne la met pas dans la partie
    @taille = taille
    @mode = mode
    @partie = Partie.creer(taille)
    @solution = creerExemple15x15
    initGridGraphique
    #initIndices

  end

  def initGridGraphique
    laGrille = @partie.getCurrentGrid()
    boxGrille = @boxGrille


    table = Gtk::Table.new(@taille,@taille)
    #Generation des pixbufs
    imageWhiteBuf = GdkPixbuf::Pixbuf.new(:file => "./IHM/fr/fonds/blancGrille15x15.png")
    imageBlackBuf = GdkPixbuf::Pixbuf.new(:file => "./IHM/fr/fonds/noirGrille15x15.png")
    imageCrossBuf = GdkPixbuf::Pixbuf.new(:file => "./IHM/fr/fonds/croixGrille15x15.png")

    0.upto(@taille-1) do |i|
      0.upto(@taille-1) do |j|
        b = Gtk::Image.new(:pixbuf => imageWhiteBuf)
        event_box = Gtk::EventBox.new.add(b)
        event_box.signal_connect("button_press_event") do |eventBox,event|
          #Propagation de l'evenement a la cellule
          #ATTENTION LES EVENEMENT double et triple clic ne sont pas desactivés !
          #On peut donc double cliquer et triple cliquer mais cela ne fait rien
          #C'est normal car l'evenement n'est pas gerer
          #Il faudrait verifier un autre variable de event pour savoir si le clique est simple, double ou triple
          cell = laGrille.getCellule(j,i)
          if event.button == 1
            couleur = cell.clicGauche
            eventBox.each do |child|
              p child
              eventBox.remove(child)
            end
          elsif event.button == 3
            couleur = cell.clicDroit
            eventBox.each do |child|
              p child
              eventBox.remove(child)
            end
          else
            couleur = nil
            puts "Aucun evenement lié au bouton"+event.button.to_s
          end
          #Application de la nouvelle couleur
          if couleur == BLANC
            b = Gtk::Image.new(:pixbuf => imageWhiteBuf)
            eventBox.add(b)
            #set image blanc
          elsif couleur == NOIR
            b = Gtk::Image.new(:pixbuf => imageBlackBuf)
            eventBox.add(b)
            #setIMageNoir
          elsif couleur == CROIX
            b = Gtk::Image.new(:pixbuf => imageCrossBuf)
            eventBox.add(b)
            #image forcement croix grace aux constantes
          else

          end
          eventBox.show_all
          #Verification si la grille est correcte
          puts (verifierCorrect() ? "Gagné" : "Essai encore")
        end
        table.attach(event_box, i, i+1, j, j+1,nil,nil,2,1)
      end
    end
    boxGrille.add(table)
    boxGrille.show_all
  end

  def verifierCorrect()
    return @solution.equals(@partie.getCurrentGrid())
  end

  def creerExemple15x15
    grille = Grille.creer(15,15)
    fic=File.open('../GrillesSolution/facile1515elephant.txt','r')
    x = -1
    y = -1
    #pur chaque ligne de notre fichier fic
    fic.each_line do |l|
      x+=1
      #on prend la ligne et on la transforme char par char en int
      l.chomp.each_char do |c|
          y+=1
          if c.to_i == 0
            #white
            #puts "la"
            grille.ajouterCellule(Cellule.creer(BLANC,true),x,y)
          else
            #black
            #puts "al"
            grille.ajouterCellule(Cellule.creer(NOIR,true),x,y)
          end
      end
      y=-1
    end
    return grille
  end

  #Bouton quitter
  def quitter()
    #puts("Je m'en vais")
    Gtk.main_quit
  end
end

builder = PartieIHM.new(15,CLASSE15)
Gtk.main
