@signin
Fonctionnalité: Inscription d'un utilisateur
En tant que visiteur
Je veux pouvoir m'inscrire
Afin de bénéficier des fonctionnalités supplémentaires

En tant qu'administrateur du site
Je veux qu'un visiteur désirant s'inscrire vérifie sa boite au lettre pour valider son inscription 
Afin d'empêcher qu'un robot ne puisse s'inscrire


  Scénario: visiteur s'enregistre en donnant uniquement son email
    Soit le site est correctement configuré
    Et le site est en language "fr"
    
    Lorsque je vais sur la page d'inscription
    Et je donne mon email
    
    Alors je devrais voir "Votre compte a été crée"
    Et je devrais être sur la page d'accueil
    Et je devrais recevoir un email
    
    Lorsque j'ouvre l'email avec le sujet "Vous devez activer votre compte"
    Et je clique sur le lien d'activation dans l'email
    
    Alors je devrais être sur la page d'activation
    Et je devrais voir "Activé votre compte"
    
    Lorsque je définis un mot de passe
    
    Alors je devrais voir "Votre compte a été activé"
    Et je devrais être sur la page de mon compte
    Et je devrais recevoir un email
    
    Lorsque j'ouvre l'email avec le sujet "Votre compte est activé"
    
    Alors je devrais voir "Votre compte est activé" dans le sujet
    
  Scénario: un utilisateur n'a pas accès a la page d'enregistrement s'il est identifié
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles             |
      | franck@test.fr  | utilisateur       |
    
    Et le site est correctement configuré
    Et je suis identifié en tant que "franck@test.fr"
    Et je suis sur la page d'accueil
    
    Lorsque je vais sur la page d'inscription
    
    Alors je devrais voir "Vous devez vous déconnecter pour avoir accès à cette page"
    Et je devrais être sur la page d'accueil
    