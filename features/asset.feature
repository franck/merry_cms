@asset
Fonctionnalité: Gestion des média (photo, fichiers, ...)
En tant que rédacteur
J'aimerais être capable d'ajouter des photos et autres fichiers au site
Afin de pouvoir illustrer mes articles ou fournir des pièces jointes à mes visiteurs (pdf, doc, xls ...)

  Scénario: lister les média
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Lorsque je vais sur la page des médias
    Alors je devrais voir "Aucun média"

  Scénario: ajouter un média
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Et je suis sur la page des médias
    
    Lorsque je clique sur le lien "Ajouter un média"
    
    Alors je devrais être sur la page de création d'un média
    
    Lorsque je remplis "titre" avec "mon premier média"
    Et je remplis "Mots clés" avec "tag1"
    Et j attache le fichier "public/images/big_doc.png" à "image"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "Média ajouté"
    Et je devrais voir "mon premier média"
    Et je devrais voir "tag1"
    Et je devrais voir "big_doc.png"
    Et je devrais être sur la page des médias
    
  Scénario: impossible de créer un article sans titre ou sans fichier
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Et je suis sur la page de création d'un média
    
    Lorsque je clique sur "Ajouter"
    
    Alors je ne devrais pas voir "Média ajouté"
    Et je devrais voir "Vous devez donner un nom à ce média"
    Et je devrais voir "Vous devez importer une image"
  
  Scénario: supprimer un média
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les médias suivants dans la base:
     | titre            |
     | premier média    |
     | deuxieme média   |  
    Et je suis sur la page des médias
    
    Alors je devrais voir 2 médias
    
    Lorsque je clique sur le lien pour supprimer un média
    
    Alors je devrais voir un média
    
  
  Scénario: modifier un média
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les médias suivants dans la base:
     | titre            |
     | premier média    |
    Et je suis sur la page des médias
    
    Lorsque je clique sur le lien "modifier"
    
    Alors je devrais être sur la page de modification d'un média
    
    Lorsque je remplis "titre" avec "un nouveau titre pour ce média"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "Média modifié"
    Et je devrais être sur la page des médias
    Et je devrais voir "un nouveau titre pour ce média"
    Et je ne devrais pas voir "premier média"
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  