@translation
Fonctionnalité: Traduction des articles et catégories
En tant que rédacteur
J'aimerai pouvoir traduire mes articles et catégorie
Afin d'élargir la base de mes lecteurs
  

  Scénario: Créer une catégorie dans la langue actuelle
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom   | parent    |
     | root  |           |
    Et je suis sur la page de création d'une catégorie
      
    Lorsque je remplis "Nom" avec "première catégorie"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "première catégorie"
    Et "première catégorie" devrait être traduite en "fr"
      
  
  Scénario: Créer une catégorie dans une langue différente
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom   | parent    |
     | root  |           |
    Et je suis sur la page de création d'une catégorie
      
    Lorsque je remplis "Nom" avec "first category"
    Et je sélectionne "en" dans "Vous créez cette catégorie en"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "first category"
    Et "first category" devrait être traduite en "en"
  
  
  Scénario: Traduire une catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom   | parent    |
     | root  |           |
    Et je suis sur la page de création d'une catégorie
      
    Lorsque je remplis "Nom" avec "première catégorie"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "première catégorie"
    Et "première catégorie" devrait être traduite en "fr"
    
    Lorsque je clique sur le lien "modifier" la catégorie "première catégorie"
    Et je sélectionne "en" dans "Traduire cette categorie en"
    Et je clique sur "commencer la traduction"
    
    Alors je devrais être sur la page de modification d'une catégorie
    
    Lorsque je remplis "Nom" avec "first category"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "première catégorie"
    Et "première catégorie" devrait être traduite en "fr"
    Et "première catégorie" devrait être traduite en "en"
    
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first category"
    
    Lorsque je clique sur le lien "fr"
    Et je clique sur le lien "modifier" la catégorie "première catégorie"
    
    Alors je devrais être sur la page de modification d'une catégorie
    Et je devrais voir "première catégorie"
    
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first category"
    
    Lorsque je clique sur le lien "fr"
    Et je sélectionne "en" dans "Vous modifiez cette catégorie en"
    Et je clique sur "changer"
    
    Alors je devrais être sur la page de modification d'une catégorie
    Et je devrais voir "first category"
    
    Lorsque je remplis "Nom" avec "first category modified"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "première catégorie"
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first category modified"
  
  
  
  Scénario: Créer un article dans la langue actuelle
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et je suis sur la page de création d'un nouvel article
      
    Lorsque je remplis "Titre" avec "premier article"
    Et je clique sur "Créer"
    
    Alors je devrais voir "premier article"
    Et l'article devrait exister en "fr"
    
    Lorsque je vais sur la page des articles
    
    Alors "premier article" ne devrait pas être traduit en "en"
    Et "premier article" ne devrait pas être traduit en "en"
    
  
  Scénario: Créer un article dans une langue différente
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et je suis sur la page de création d'un nouvel article
      
    Lorsque je remplis "Titre" avec "first article"
    Et je sélectionne "en" dans "Vous écrivez cet article en"
    Et je clique sur "Créer"
    
    Alors je devrais voir "first article"
    Et l'article devrait exister en "en"
    Et l'article ne devrait pas exister en "fr"
    
    Lorsque je vais sur la page des articles
    Alors "first article" ne devrait pas être traduit en "fr"
    Et "first article" ne devrait pas être traduit en "de"
    
      
  
  Scénario: Traduire un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les catégories suivantes dans la base:
     | nom   | parent    |
     | root  |           |
    Et je suis sur la page de création d'un nouvel article
      
    Lorsque je remplis "Titre" avec "premier article"    
    Et je sélectionne "root" dans "Catégorie"
    Et je clique sur "Créer"
    
    Lorsque je vais sur la page des articles
    
    Alors "premier article" ne devrait pas être traduit en "en"
    
    Lorsque je clique sur le lien "modifier" pour modifier l'article
    Et je sélectionne "en" dans "Traduire cet article en"
    Et je clique sur "commencer la traduction"
    
    Et je remplis "Titre" avec "first article"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "first article"
    Et l'article devrait exister en "en"
    Et l'article devrait exister en "fr"
    
    Lorsque je vais sur la page des articles
    Alors je devrais voir "premier article"
    Et je devrais voir "first article"
    Et "premier article" devrait être traduit en "en"
    
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first article"
  
    Lorsque je clique sur le lien "fr"
    Et je clique sur le lien "modifier" pour modifier l'article
    
    Alors je devrais voir "premier article"
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first article"
    
    Lorsque je clique sur le lien "fr"
    Et je sélectionne "en" dans "Vous modifiez cet article en"
    Et je clique sur "changer"
    
    Alors je devrais voir "first article"
    Lorsque je remplis "Titre" avec "first article modified"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "first article modified"
    Lorsque je vais sur la page des articles
    Alors je devrais voir "premier article"
    Lorsque je clique sur le lien "en"
    Alors je devrais voir "first article modified"
    
    Alors "first article modified" devrait être traduit en "fr"
    
    
  
  
  