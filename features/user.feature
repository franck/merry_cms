@user
Fonctionnalité: Compte de l'utilisateur
En tant qu'utilisateur
Je devrais être capable de changer mes infos personnels
Afin de pouvoir change d'email ou de mot de passe si j'en est envie

  Scénario: Un utilisateur a accès a son compte
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles             |
      | franck@test.fr  | utilisateur       |
      
    Et je suis identifié en tant que "franck@test.fr"

    Lorsque je vais sur la page de mon compte  
    Alors je devrais voir "franck@test.fr"
    
    
  Scénario: Un visiteur n'a pas accès aux comptes des utilisateurs
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et un visiteur
    Et le site est correctement configuré
    
    Lorsque je vais sur la page de mon compte
    Alors je devrais voir "Vous devez être connecté pour avoir accès à cette page"
