@reset_password
Fonctionnalité: réinitilisation du mot de passe
En tant qu'utilisateur ayant oublié mon mot de passe
Je voudrais pouvoir demander à le récupérer
Afin de pouvoir m'identifier

  Scénario: demande de réinitialisation de mot de passe avec un email valide
    Soit un utilisateur dans la base
    Et le site est correctement configuré
    Et le site est en language "fr"
    
    Lorsque je vais sur la page de réinitialisation du mot de passe
    Et je donne un email valide
    
    Alors je devrais voir "Des instructions pour modifier votre mot de passe vous ont été envoyé par email"
    Et je devrais recevoir un email
    
    Lorsque j'ouvre l'email
    
    Alors je devrais voir "Demande de reset du mot de passe" dans l'email
    
    Lorsque je clique sur le lien de réinilisation dans l'email
    
    Alors je devrais être sur la page de mise à jour du mot de passe
    
    Lorsque je mets à jour mon mot de passe
   
    Alors je devrais voir "Mot de passe mis à jour avec succès"
    Et je devrais être sur la page d'identification
    
  
  
  Scénario: demande de réinitialisation de mot de passe quand l'email n'est pas dans la base
    Soit un utilisateur dans la base
    Et le site est correctement configuré
    Et le site est en language "fr"
    
    Lorsque je vais sur la page de réinitialisation du mot de passe
    Et je donne un email qui n'existe pas
    
    Alors je devrais voir "Aucun utilisateur n'a été trouvé avec cette adresse"
    Et je devrais être sur la page de réinitialisation du mot de passe
    
    
        
  Scénario: demande de réinitialisation de mot de passe mais finalement pas de mot de passe de donné
    Soit un utilisateur dans la base
    Et le site est correctement configuré
    Et le site est en language "fr"
    
    Lorsque je demande la réinitilisation de mon mot de passe
    Et je laisse le mot de passe vide
    
    Alors je devrais être sur la page d'accueil
    Et je devrais voir "Le mot de passe n'a pas été réinitialisé"
    
    
    
    
    