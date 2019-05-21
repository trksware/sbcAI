:- dynamic( fait/1 ).

%définition des opérateurs SI, ALORS, OU, ET
:- op( 800, fx, si ),
op( 700, xfx, alors ),
op( 300, xfy, ou ),
op( 200, xfy, et ).



%Definition du SBC


%Classification des matériaux en trois sous catégories


%Classe métaux

si conducteur_electrique(Materiaux_observe , oui)
et oxyde(Materiaux_observe, oui)
alors est_un(Materiaux_observe ,metal).

si conducteur_thermique(Materiaux_observe , oui)
et oxyde(Materiaux_observe, oui)
alors est_un(Materiaux_observe ,metal).

si est_un(Materiaux_observe ,metal)
et couleur(Materiaux_observe, dore)
alors est_un(Materiaux_observe ,or).

si est_un(Materiaux_observe ,metal)
et couleur(Materiaux_observe, gris)
et magnetisme(Materiaux_observe, paramagnetique)
alors est_un(Materiaux_observe ,argent).

si est_un(Materiaux_observe ,metal)
et couleur(Materiaux_observe, gris)
et magnetisme(Materiaux_observe, oui)
alors est_un(Materiaux_observe ,fer).








%Classe materiaux organiques

si origine(Materiaux_observe , etre_vivant)
alors est_un(Materiaux_observe ,organique).

si conducteur_electrique(Materiaux_observe , non)
alors est_un(Materiaux_observe ,organique).

si conducteur_thermique(Materiaux_observe , non)
alors est_un(Materiaux_observe ,organique).

si est_un(Materiaux_observe, organique)
et liquide(Materiaux_observe, oui)
alors est_un(Materiaux_observe, resine).

si est_un(Materiaux_observe,organique)
et elastique(Materiaux_observe, oui)
alors est_un(Materiaux_observe, caoutchouc).

si est_un(Materiaux_observe,organique)
et constitution(Materiaux_observe, fibres)
alors est_un(Materiaux_observe, textile).

si est_un(Materiaux_observe,organique)
et dur(Materiaux_observe, oui)
alors est_un(Materiaux_observe, roche).












%Classe combustible fossile

si constitution(Materiaux_observe , polymere_moleculaire)
alors est_un(Materiaux_observe ,combustible_fossile).

si conducteur_electrique(Materiaux_observe , non)
et oxyde(Materiaux_observe, non)
alors est_un(Materiaux_observe ,combustible_fossile).

si conducteur_thermique(Materiaux_observe , non)
et oxyde(Materiaux_observe, non)
alors est_un(Materiaux_observe ,combustible_fossile).

si est_un(Materiaux_observe ,combustible_fossile)
et remodele(Materiaux_observe, oui)
alors est_un(Materiaux_observe ,termoplastique).

si est_un(Materiaux_observe ,combustible_fossile)
et remodele(Materiaux_observe, non)
alors est_un(Materiaux_observe,thermodurcissable).

si est_un(Materiaux_observe,combustible_fossile)
et elastique(Materiaux_observe, oui)
alors est_un(Materiaux_observe ,elastomere).





%test 1

fait( oxyde(ustensiles_de_marie,non) ).
fait( conducteur_electrique(ustensiles_de_marie,non) ).
fait( conducteur_thermique(ustensiles_de_marie,non) ).
fait( constitution(ustensiles_de_marie , polymere_moleculaire) ).



%test 2

fait( elastique(bijoux_de_jeane,non) ).
fait( oxyde(bijoux_de_jeane,oui) ).
fait( conducteur_electrique(bijoux_de_jeane,oui) ).
fait( conducteur_thermique(bijoux_de_jeane,oui) ).
fait( magnetisme(bijoux_de_jeane,paramagnetique) ).
fait( couleur(bijoux_de_jeane,gris) ).


%test 3

fait( origine(chandail_de_frederique, etre_vivant) ).
fait( constitution(chandail_de_frederique,fibres) ).
fait( conducteur_electrique(chandail_de_frederique,non) ).
fait( conducteur_thermique(chandail_de_frederique,non) ).

%Pour lancer,  faire "ch_arriere(X)." dans l'interpreteur ; remplacer X par une assertion
ch_arriere(X):- est_vrai(X).

est_vrai(X):- fait(X).
est_vrai(X):- si COND alors X, est_vrai(COND).
est_vrai( C1 et C2 ):- est_vrai(C1), est_vrai(C2).
est_vrai( C1 ou C2 ):- est_vrai(C1) ; est_vrai(C2).



%Pour lancer, faire "ch_avant." dans l'interpreteur
ch_avant:-
        si COND alors X,
        not(fait(X)),
        condition_vraie(COND),
        !,
        write('nouveau fait : '), write(X),nl,
        asserta(fait(X)),
        ch_avant.
ch_avant:- write(' La BC est saturée'), nl.

/* condition_vraie/1 : même chose que le prédicat est_vrai/1, mais sans remonter dans les règles à partir des buts */
condition_vraie(C):- fait(C).
condition_vraie(C1 et C2):- condition_vraie(C1), condition_vraie(C2).
condition_vraie(C1 ou C2):- condition_vraie(C1) ; condition_vraie(C2).

