@login
Fonctionnalité: Identification d'un utilisateur
En tant que visiteur
Je veux pouvoir m'identifier
Afin de bénéficier des fonctionnalités restreintes du site


  Scénario: visiteur avec les bons identifiants
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et un utilisateur dans la base
    Et le site est correctement configuré
    
    Lorsque je vais sur la page d'identification
    Et je renseigne le formulaire d'inscription avec de bons identifiants
    
    Alors je devrais voir "Vous êtes connecté"
    Et je devrais voir le lien "se déconnecter"
    
  
  Scénario: visiteur avec de mauvais identifiants
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et un utilisateur dans la base
    Et le site est correctement configuré
  
    Lorsque je vais sur la page d'identification
    Et je donne un email qui n'est pas dans la base
  
    Alors je devrais voir "Cet email n'est pas dans nos base"
    
    Lorsque je donne un mauvais mot de passe
    
    Alors je devrais voir "Le mot de passe n'est pas valide"