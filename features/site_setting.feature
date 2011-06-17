@site_setting
Fonctionnalité: gestion des préférences du site
En tant qu'administrateur
J'aimerai pouvoir changer les préférences du site
Afin d'avoir un controle plus simple sur des paramètres tel que le titre du site, le code Google Analtics, les langues ...


  Scénario: voir les préférences
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "admin"
    
    Lorsque je vais sur la page des préférences
    
    Alors je devrais voir "Titre du site"
    Et je devrais voir "Default Title"
    Et je devrais voir "Clé Google Analytics"
    Et je devrais voir "aucune"

  Scénario: modifier le titre du site
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "admin"
    Et je suis sur la page des préférences
    
    Lorsque je clique sur le lien "modifier"
    
    Alors je devrais voir "Mettre à jour"
    
    Lorsque je remplis "Titre du site" avec "Mon site"
    Et je clique sur "Mettre à jour"
    
    Alors je devrais voir "Préférences mises à jour"
    Et je devrais être sur la page des préférences
    Et je devrais voir "Mon site"
    
  Scénario: modifier la langue
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "admin"
    Et je suis sur la page des préférences
    
    Lorsque je clique sur le lien "modifier"
    Et je coche la langue "de"
    Et je coche la langue "fr"
    Et je coche la langue "en"
    Et je clique sur "Mettre à jour"
    
    Alors je devrais voir "fr, de, en"
    
  Scénario: lorsque je modifie la langue pour une langue qui n'est pas la langue actuelle alors je bascule sur cette nouvelle langue
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "admin"
    Et je suis sur la page des préférences
    
    Lorsque je clique sur le lien "modifier"
    Et je coche la langue "fr"
    Et je clique sur "Mettre à jour"
    
    Alors je devrais voir "<strong>Langues</strong> : fr"
    Et je devrais voir "Préférences mises à jour"
    
    Lorsque je clique sur le lien "modifier"
    Et je coche la langue "en"
    Et je décoche la langue "fr"
    Et je décoche la langue "de"
    Et je clique sur "Mettre à jour"
    
    Alors je devrais voir "<strong>Languages</strong> : en"
    Et je devrais voir "Site settings updated"


    
  
  