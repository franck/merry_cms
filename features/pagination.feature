 @pagination
Fonctionnalité: Pagination des utilisateurs
En tant qu'administrateur
Je voudrais être capable de manipuler mon tableau d'utilisateurs
Afin de ne pas avoir un tableau trop grand, de pouvoir filtrer le contenu par email ou par roles, ou encore de trier par email

  Scénario: voir un nombre limiter de valeurs dans le tableau
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Soit les personnes suivantes dans la base
      | email             | roles  |
      | admin@test.fr     | admin  |
      | franck1@test.fr   | user   |
      | franck2@test.fr   | user   |
      | franck3@test.fr   | user   |
      | franck4@test.fr   | user   |
      | franck5@test.fr   | user   |
      | franck6@test.fr   | user   |
      | franck7@test.fr   | user   |
      | franck8@test.fr   | user   |
      | franck9@test.fr   | user   |
      | franck10@test.fr  | user   |
      | franck11@test.fr  | user   |

    Et je suis identifié en tant que "admin@test.fr"
    
    Lorsque je suis sur la page d'administration des utilisateurs
    
    Alors je devrais voir 10 utilisateurs
    
    Lorsque je clique sur le lien "2"
    
    Alors je devrais voir 2 utilisateurs
      
  
  Scénario: choisir le nombre de valeurs a afficher par pages
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email             | roles  |
      | admin@test.fr     | admin  |
      | franck1@test.fr   | user   |
      | franck2@test.fr   | user   |
      | franck3@test.fr   | user   |
      | franck4@test.fr   | user   |
      | franck5@test.fr   | user   |
      | franck6@test.fr   | user   |
      | franck7@test.fr   | user   |
      | franck8@test.fr   | user   |
      | franck9@test.fr   | user   |
      | franck10@test.fr  | user   |
      | franck11@test.fr  | user   |

    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
      
    Lorsque je sélectionne "5" dans "Par page"
    Et je clique sur "Go"
      
    Alors je devrais voir 5 utilisateurs
      
      
  Scénario: filtrer les valeurs du tableau
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck1@test.fr | user   |
      | franck2@test.fr | user   |
      | franck3@test.fr | user   |
      | franck4@test.fr | user   |
      | franck5@test.fr | user   |
      | franck6@test.fr | user   |
      | bob1@test.fr    | user   |
      | bob2@test.fr    | user   |
      | bob3@test.fr    | user   |
      | bob4@test.fr    | user   |
      | léon1@test.fr   | user   |

    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Lorsque je remplis "filtrer" avec "franck"
    Et je clique sur "Go"
    
    Alors je devrais voir 6 utilisateurs
    
    Lorsque je sélectionne "5" dans "Par page"
    Et je clique sur "Go"
    
    Alors je devrais voir 5 utilisateurs avec le pattern "franck"
    
  Scénario: trier le tableau par email
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck1@test.fr | user   |
      | franck2@test.fr | user   |
      | franck3@test.fr | user   |
      | franck4@test.fr | user   |
      | franck5@test.fr | user   |
      | franck6@test.fr | user   |
      | bob1@test.fr    | user   |
      | bob2@test.fr    | user   |
      | bob3@test.fr    | user   |
      | bob4@test.fr    | user   |
      | léon1@test.fr   | user   |

    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Alors je devrais voir le tableau d'utilisateurs suivant:
      | email           |
      | admin@test.fr   |
      | bob1@test.fr    |
      | bob2@test.fr    |
      | bob3@test.fr    |
      | bob4@test.fr    |
      | franck1@test.fr |
      | franck2@test.fr |
      | franck3@test.fr |
      | franck4@test.fr |
      | franck5@test.fr |
      
    Lorsque je clique sur le lien "Email"
  
    Alors je devrais voir le tableau d'utilisateurs suivant:
      | email           |
      | franck6@test.fr |
      | franck5@test.fr |
      | franck4@test.fr |
      | franck3@test.fr |
      | franck2@test.fr |
      | franck1@test.fr |
      | bob4@test.fr    |
      | bob3@test.fr    |
      | bob2@test.fr    |
      | bob1@test.fr    |
      
  Scénario: filtrer les valeurs du tableau par roles
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck1@test.fr | admin  |
      | franck2@test.fr | admin  |
      | franck3@test.fr | admin  |
      | franck4@test.fr | user   |
      | franck5@test.fr | user   |
      | franck6@test.fr | user   |
      | bob1@test.fr    | user   |
      | bob2@test.fr    | user   |
      | bob3@test.fr    | user   |
      | bob4@test.fr    | user   |
      | léon1@test.fr   | user   |

    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs

    Lorsque je remplis "filtrer" avec "administrateur"
    Et je clique sur "Go"

    Alors je devrais voir 4 utilisateurs
  
  Scénario: afficher "aucun utilisateur" si tous filtrés
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck1@test.fr | admin  |
      | franck2@test.fr | admin  |
      | franck3@test.fr | admin  |
      | franck4@test.fr | user   |
      | franck5@test.fr | user   |
      | franck6@test.fr | user   |
      | bob1@test.fr    | user   |
      | bob2@test.fr    | user   |
      | bob3@test.fr    | user   |
      | bob4@test.fr    | user   |
      | léon1@test.fr   | user   |

    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs

    Lorsque je remplis "filtrer" avec "truc bidulle"
    Et je clique sur "Go"

    Alors je devrais voir "Aucun utilisateur"
    


