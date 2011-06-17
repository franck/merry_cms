@admin
Fonctionnalité: Administration des utilisateurs
En tant qu'administrateur
Je veux gérer les utilisateurs du site
Afin d'être le maitre à bord

  Scénario: seul un administrateur a accès a cet espace
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles |
      | gerard@test.fr  |       |
    Et je suis identifié en tant que "gerard@test.fr"
    Et je suis sur la page d'accueil
    
    Lorsque je vais sur la page d'administration des utilisateurs
    
    Alors je devrais voir "Accès refusé"
    Et je devrais être sur la page d'accueil
    
  Scénario: lister les utilisateurs
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | gerard@test.fr  |        |
      | robert@test.fr  |        |
      
    Et je suis identifié en tant que "admin@test.fr"
  
    Lorsque je vais sur la page d'administration des utilisateurs
    
    Alors je devrais voir 3 utilisateurs
    
    
  Scénario: créer un utilisateur sans roles
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Lorsque je clique sur le lien "Ajouter un utilisateur"
    
    Alors je devrais être sur la page de création d'un nouvel utilisateur
    Et je devrais voir le formulaire de création
    Et je devrais voir tous les rôles disponibles
    
    Lorsque je remplis le formulaire avec des valeurs correctes
    
    #Alors je devrais être sur la page d'administration des utilisateurs
    Alors je devrais voir "Utilisateur ajouté dans la base"
    Et l'utilisateur "franck@test.fr" devrait être actif
    
    
  Scénario: créer un utilisateur avec le role administrateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page de création d'un nouvel utilisateur
    
    Lorsque je remplis le formulaire en cochant le role administrateur
    
    Alors je devrais voir "Utilisateur ajouté dans la base"
    Et je devrais voir le role "administrateur" pour l'utilisateur "franck@test.fr"
    
  
  Scénario: impossible de créer un utilisateur si la confirmation du mot de passe ne concorde pas
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page de création d'un nouvel utilisateur
    
    Lorsque je remplis "email" avec "gerard@test.fr"
    Et je remplis "Mot de passe" avec "goodpassword"
    Et je remplis "Confirmation du mot de passe" avec "badpassword"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "La confirmation ne concorde pas avec le mot de passe"
    
    
    
  Scénario: supprimer un utilisateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck@test.fr  | user   |
      
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Lorsque je clique sur le lien pour supprimer un utilisateur
    
    Alors je devrais voir uniquement l'utilisateur "admin"
    Et je devrais voir "Utilisateur supprimé"
  
    
  Scénario: impossible de supprimer un administrateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et un utilisateur dans la base
    Et je suis identifié en tant que "administrateur"
    
    Lorsque je suis sur la page d'administration des utilisateurs
    
    Alors je ne devrais pas pouvoir supprimer un administrateur
  
  
    
  Scénario: impossible de désactiver un administrateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  | active  |
      | admin@test.fr   | admin  | true    |
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
  
    Alors je ne devrais pas voir "désactiver"
    
  Scénario: impossible de retirer le role "admin" du dernier administrateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  | active  |
      | admin@test.fr   | admin  | true    |
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs

    Lorsque je clique sur le lien "modifier"
    Et je clique sur "Modifier"

    Alors je ne devrais pas voir "Accès refusé"
    Et je devrais voir "Utilisateur modifié"
    
  
  Scénario: mais pas impossible d'activer un administrateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  | active  |
      | admin@test.fr   | admin  | true    |
      | admin2@test.fr  | admin  | false   |
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Lorsque je coche "active"
    Et je clique sur "Go"

    Alors je devrais voir "admin2@test.fr"
    Et l'utilisateur "admin2@test.fr" ne devrait pas être actif
    Et l'utilisateur "admin2@test.fr" devrait pouvoir être activer
    
  
  Scénario: modifier les rôles d'un utilisateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  |
      | admin@test.fr   | admin  |
      | franck@test.fr  | writer   |
      
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    
    Lorsque je clique sur le lien "modifier" pour l'utilisateur "franck@test.fr"
    
    Alors je devrais voir "franck@test.fr"
    Et je devrais voir "administrateur"
    Et je devrais voir "rédacteur"
    
    Lorsque je coche le role "admin"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "Utilisateur modifié"
    #Et je devrais être sur la page d'administration des utilisateurs
    Et je devrais voir le role "administrateur" pour l'utilisateur "franck@test.fr"
    
    Lorsque je clique sur le lien "modifier" pour l'utilisateur "franck@test.fr"
    Et je coche le role "rédacteur"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "Utilisateur modifié" 
    #Et je devrais être sur la page d'administration des utilisateurs
    Et je devrais voir le role "rédacteur" pour l'utilisateur "franck@test.fr"
  
  Scénario: activer un utilisateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles  | active  |
      | admin@test.fr   | admin  | true    |
      | franck@test.fr  | user   | false   |
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs
    Et je coche "active"
    Et je clique sur "Go"
    
    Lorsque je clique sur le lien "activer" pour l'utilisateur "franck@test.fr"
    
    Alors je devrais voir "Utilisateur activé"
    Et l'utilisateur "franck@test.fr" devrait être actif
 
  Scénario: désactiver un utilisateur
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et les personnes suivantes dans la base
      | email           | roles | active  |
      | admin@test.fr   | admin | true    |
      | franck@test.fr  | user  | true    |
    Et je suis identifié en tant que "admin@test.fr"
    Et je suis sur la page d'administration des utilisateurs

    Lorsque je clique sur le lien "désactiver" pour l'utilisateur "franck@test.fr"

    Alors l'utilisateur "franck@test.fr" ne devrait pas être actif
    Et je devrais voir "Utilisateur désactivé"
    