require 'gtk3'
load '../Constants.rb'
load '../Grille/Partie.rb'
load '../Grille/GroupeIndice.rb'


LANGAGE = "fr"
class PartieIHM < Gtk::Builder

  @taille #Taille de la grille
  @mode #mode de jeu
  @chrono #le chronometre
  @partie #la partie
  @cliquerGlisser #boolean indiquant si l'on est en mode cliquer-gliser ou pas
  @table

  private_class_method :new
  def PartieIHM.creer(taille, mode)
    new(taille,mode)
  end

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

    #Il manque la gestion du chrono
    #Generation de la partie
    @table = Array.new
    @taille = taille #Initialisation de la taille
    @mode = mode #Initialisation du mode
    @partie = Partie.creer(taille) #Generation de la partie (Indépendante du mode)
    @solution = creerExemple15x15 #Generation de la solution (A REVOIR CECI EST UN EXEMPLE)
    initGridGraphique #Initialisation de la grille
    initIndices #Initialisation des indices
  end


  #Genere les indices des colonnes et des lignes
  def initIndices
    #Generation des indices de colonne
    0.upto(@taille-1) do |i|
      ind = GroupeIndice.creer(@solution.getColonne(i))
      button = Gtk::Button.new(:label =>ind.tabIndice.join("\n"))
      button.signal_connect("button_press_event") do |eventBox,event|
        isTabDisplay = ind.toggle
        if(isTabDisplay)
          button.label=ind.tabIndice.join("\n")
        else
          button.label=ind.somme.to_s
        end
      end
      @boxIndiceCol.add(button)
    end
    @boxIndiceCol.show_all
    #Generation des indices de ligne
    0.upto(@taille-1) do |i|
      ind = GroupeIndice.creer(@solution.getLigne(i))
      button = Gtk::Button.new(:label =>ind.tabIndice.join(" "))
      button.signal_connect("button_press_event") do |eventBox,event|
        isTabDisplay = ind.toggle
        if(isTabDisplay)
          button.label=ind.tabIndice.join(" ")
        else
          button.label=ind.somme.to_s
        end
      end
      @boxIndiceLig.add(button)
    end
    @boxIndiceLig.show_all
  end

  #Initalise la grille graphique avec que des cases blanches
  #Creer les evenements pour chaque case
  def initGridGraphique
    #Creation de la table aux bonnes dimensions
    table = Gtk::Table.new(@taille,@taille)
    #Generation des pixbufs
    case @taille
    when 10
      @imageWhiteBuf = GdkPixbuf::Pixbuf.new(:file => BLANC10)
      @imageBlackBuf = GdkPixbuf::Pixbuf.new(:file => NOIR10)
      @imageCrossBuf = GdkPixbuf::Pixbuf.new(:file => CROIX10)
    when 15
      @imageWhiteBuf = GdkPixbuf::Pixbuf.new(:file => BLANC15)
      @imageBlackBuf = GdkPixbuf::Pixbuf.new(:file => NOIR15)
      @imageCrossBuf = GdkPixbuf::Pixbuf.new(:file => CROIX15)
    when 20
      @imageWhiteBuf = GdkPixbuf::Pixbuf.new(:file => BLANC20)
      @imageBlackBuf = GdkPixbuf::Pixbuf.new(:file => NOIR20)
      @imageCrossBuf = GdkPixbuf::Pixbuf.new(:file => CROIX20)
    end
    #Pour chaque case
    0.upto(@taille-1) do |i|
      @table.push(Array.new)
      0.upto(@taille-1) do |j|
        #Creation de l'image (Etape obligatoire les eventBox doivent avoir leur
        #propre instance de l'image)
        b = Gtk::Image.new(:pixbuf => @imageWhiteBuf)
        #Creation de l'event box et ajout de l'image dans celle ci
        event_box = Gtk::EventBox.new.add(b)
        @table[i].push(event_box)
        #Capture du signal button_press_event correspondant au clique simple, double ou triple
        event_box.signal_connect("button_press_event") do |eventBox,event|
          #Sauvegarde du clique (gauche ou droit, necessaire pour l'evenement enter_notify_event qui ne permet
          #pas de savoir quel bouton de la souris est appuyé)
          @clique = event.button
          #Lors d'un clique souris on active le mode cliquerGlisser
          @cliquerGlisser = true
          #Mise a jour de la case graphique et de la case interne au jeu
          updateOnClick(@partie.getCellAt(j,i),eventBox)
          #Verification si la grille est correcte
          if verifierCorrect()
            onWin()
          end
          #Desactivation du grab pour le cliquer glissé
          #(Obligatoirement ici, independant pour chaque case)
          Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
        end

        #Capture du signal button_release_event corr au relachement d'un boutton de souris
        event_box.signal_connect("button_release_event") {
          #Lors du relachement on desactive le cliquer-glissé
					@cliquerGlisser = false
				}

        #Capture du signal enter_notify_event correspondant a l'entre du pointeur
        #de souris dans une cellue
        event_box.signal_connect("enter_notify_event") { |eventBox, event|
          #Si on est en mode cliquer glissé (rien a faire dans les autre cas)
          if @cliquerGlisser
            #Mise a jour de la case graphique et de la case interne au jeu
            updateOnClick(@partie.getCellAt(j,i),eventBox)
          end
				}
        #Ajout de l'event box a la table
        table.attach(event_box, i, i+1, j, j+1,nil,nil,2,1)
      end
    end
    #Ajout de la table a la fenetre
    @boxGrille.add(table)
    #Affichage de la table
    @boxGrille.show_all
  end

  #Gere les actions a effectuer lors d'un clic
  def updateOnClick(cellule,eventBox)
    #Recuperation de la nouvelle couleur
    couleur = calculCouleur(cellule,@clique)
    #Application de la nouvelle couleur
    updateEventBox(eventBox,couleur)
  end

  #Calcul et retourne la nouvelle couleur (Met donc a jour la cellule interne du jeu)
  def calculCouleur(cellule,clique)
    #Gestion du clique gauche
    if clique == CLIQUEGAUCHE
      couleur = cellule.clicGauche
    #Gestion duclique droit
    elsif clique == CLIQUEDROIT
      couleur = cellule.clicDroit
    #Aucune gestion pour tout les autres boutons de la souris
    else
      couleur = nil
      puts "Aucun evenement lié au bouton"+clique.to_s
    end
    return couleur
  end

  #Mise a jour graphique de la cellule
  def updateEventBox(eventBox,couleur)
    #Il est possible de faire differement mais la flemme.
    #Suppression de l'image actuel de l'eventBox
    eventBox.each do |child|
      eventBox.remove(child)
    end
    #Ajout de la nouvelle image
    if couleur == BLANC
      b = Gtk::Image.new(:pixbuf => @imageWhiteBuf)
      eventBox.add(b)
      #set image blanc
    elsif couleur == NOIR
      b = Gtk::Image.new(:pixbuf => @imageBlackBuf)
      eventBox.add(b)
      #setIMageNoir
    elsif couleur == CROIX
      b = Gtk::Image.new(:pixbuf => @imageCrossBuf)
      eventBox.add(b)
    else
    end
    #Mise a jour graphique
    eventBox.show_all
  end


  #Methode declenchée en case de victoire
  #Methode dependante du mode !!!!
  #Fait ce qui doit être fait en cas de victoire
  #ex: pour le mode classé, si le score est bon alors proposé de l'ajoutter.
  def onWin
    case @mode
    when CLASSE
      puts "Gagné"
    when CONTREMONTRE
    when AVENTURE
    end
  end

  #Renvoi vrai si la grille actuel du joueur est correct
  def verifierCorrect()
    return @solution.equals(@partie.getCurrentGrid())
  end

  #Creer la grille INTERNE de l'exemple 15x15 situé dans ../GrillesSolution/facile1515elephant.txt
  def creerExemple15x15
    grille = Grille.creer(15,15)
    fic=File.open('../GrillesSolution/facile1515elephant.txt','r')
    x = -1
    y = -1
    #pur chaque ligne du fichier
    fic.each_line do |l|
      #on incremente le compteur de ligne
      x+=1
      #on affecte a chaque caractère 0 ou 1 du fichier, la cellule de la couleur correspondante
      #0 pour blanc et 1 pour noir
      l.chomp.each_char do |c|
          y+=1
          if c.to_i == 0
            grille.ajouterCellule(Cellule.creer(BLANC,true),x,y)
          else
            grille.ajouterCellule(Cellule.creer(NOIR,true),x,y)
          end
      end
      y=-1
    end
    return grille
  end

  #Bouton quitter
  def quitter()
    Gtk.main_quit
  end
end

builder = PartieIHM.creer(15,CLASSE)
Gtk.main
