@cms
Fonctionnalité: CMS
En tant que rédacteur
Je veux être capable de publier des articles
Afin que les visiteurs puissent lire mes articles  

  Scénario: lister les articles
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    
    Lorsque je vais sur la page des articles
    
    Alors je devrais voir "Aucun article"

    
  Scénario: créer un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "Nouvel article"
    
    Alors je devrais être sur la page de création d'un nouvel article
    
    Lorsque je remplis "titre" avec "mon premier article"
    Et je clique sur "Créer"
    
    Alors je devrais voir "Article crée"
    Et je devrais voir "mon premier article"
    Et je devrais être sur la page qui affiche l'article
  
    
  Scénario: impossible de créer un article sans titre
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et je suis sur la page de création d'un nouvel article
    
    Lorsque je clique sur "Créer"
    
    Alors je ne devrais pas voir "Article crée"
    
  Scénario: voir un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
     | titre            |
     | premier article  |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "premier article"
    
    Alors je devrais voir le titre "premier article"
    
  Scénario: supprimer un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            |
     | premier article  |
     | deuxieme article |
    Et je suis sur la page des articles
     
    Alors je devrais voir 2 articles
    
    Lorsque je clique sur le lien pour supprimer un article
    
    Alors je devrais voir un article
  
  Scénario: modifier un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
      | titre            |
      | premier article  |
    Et les catégories suivantes dans la base:
      | nom   | parent    |
      | root  |           |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "modifier" pour modifier l'article
    
    Alors je devrais voir "premier article"
    Et je devrais être sur la page de modification d'un article
  
    Lorsque je remplis "titre" avec "deuxième article"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "Article modifié"
    Et je devrais voir "deuxième article"
    Et je devrais être sur la page qui affiche l'article
  
  Scénario: afficher le permalink dans la page d'edition de l'article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
     | titre            |
     | premier article  |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "modifier"
    
    Alors je devrais voir "premier-article"
  
  Scénario: modifier le status de "en cours" à "publié"
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | en cours  |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "publier"
    
    Alors je devrais voir le status "publié" dans le tableau des article
  
  
  Scénario: modifier le status de "publié" à "en cours"
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | publié  |
    Et je suis sur la page des articles
  
    Lorsque je clique sur le lien "dépublier"
  
    Alors je devrais voir le status "en cours" dans le tableau des article

  
  Scénario: modifier le status de "en cours" à "archivé"
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | en cours  |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "archiver"
    
    Alors je devrais voir le status "archivé" dans le tableau des article
  
  
  Scénario: modifier le status de "archivé" à "en cours"
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | archivé   |
    Et je suis sur la page des articles
    
    Lorsque je clique sur le lien "désarchiver"
    
    Alors je devrais voir le status "en cours" dans le tableau des article


  Scénario: créer un article taggé
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et je suis sur la page de création d'un nouvel article
    
    Lorsque je remplis "Titre" avec "Un article"
    Et je remplis "Mots clés" avec "tag1, tag2"
    Et je clique sur "Créer"
    Alors je devrais voir "Article crée"
    
    Lorsque je vais sur la page des articles
    
    Alors je devrais voir "tag1"
    Et je devrais voir "tag2"
  
  
  Scénario: modifier un article taggé
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
     | titre            | status    | keywords  |
     | premier article  | archivé   | tag1      |
    Et je suis sur la page des articles

    Lorsque je clique sur le lien "modifier" pour modifier l'article
    Et je remplis "Mots clés" avec "tag2"
    Et je clique sur "Modifier"
    Et je vais sur la page des articles
   
    Alors je devrais voir "tag2"
    Et je ne devrais pas voir "tag1"
    
    
    
  Scénario: supprimer un tag d'un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
     | titre            | status    | keywords  |
     | premier article  | archivé   | tag1      |
    Et je suis sur la page des articles

    Lorsque je clique sur le lien "modifier" pour modifier l'article
    Et je remplis "Mots clés" avec ""
    Et je clique sur "Modifier"
   
    Alors je ne devrais pas voir "tag1"
    
  Scénario: créer une première catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et je suis sur la page des catégories
   
    Alors je devrais voir "Aucune catégorie"
   
    Lorsque je clique sur le lien "Ajouter une catégorie"
    Alors je devrais être sur la page de création d'une catégorie
   
    Lorsque je remplis "Nom" avec "ma première catégorie"
    Et je clique sur "Ajouter"
   
    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "ma première catégorie"
   
  Scénario: impossible de créer un catégorie sans nom
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et je suis sur la page de création d'une catégorie

    Lorsque je remplis "Nom" avec ""
    Et je clique sur "Ajouter"

    Alors je devrais voir "Vous devez donner un nom"
  
  Scénario: ajouter une sous catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom   | parent    |
     | root  |           |
    Et je suis sur la page des catégories
    
    Alors je devrais voir "root"
    
    Lorsque je clique sur le lien "Ajouter une catégorie"
    
    Alors je sélectionne "root" dans "Parent"
    Et je remplis "Nom" avec "cat1"
    Et je clique sur "Ajouter"
    
    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "cat1" sur un niveau
    
  Scénario: ajouter une sous sous catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom    | parent    |
     | root   |           |
     | cat1   | root      |
    Et je suis sur la page de création d'une catégorie

    Lorsque je sélectionne "cat1" dans "Parent"
    Et je remplis "Nom" avec "cat2"
    Et je clique sur "Ajouter"

    Alors je devrais voir "Catégorie créée"
    Et je devrais voir "cat2" sur 2 niveaux
  
  Scénario: supprimer une catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom    | parent    |
     | root   |           |
     | cat1   | root      |
     | cat2   | cat1      |
    Et je suis sur la page des catégories
    
    Alors je devrais voir "root"
    Et je devrais voir "cat1"
    
    Lorsque je clique sur le lien pour supprimer la catégorie "cat1"
    
    Alors je devrais voir "root"
    Et je ne devrais pas voir "cat1"
    Et je ne devrais pas voir "cat2"
    
  Scénario: modifier une catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher-in-chief"
    Et les catégories suivantes dans la base:
     | nom    | parent    |
     | root   |           |
     | cat1   | root      |
     | cat2   | cat1      |
    Et je suis sur la page des catégories
    
    Lorsque je clique sur le lien "modifier" la catégorie "cat1"
    Et je remplis "Nom" avec "cat3"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "cat3" sur un niveau
    Et je devrais voir "cat2" sur 2 niveaux
    
    Lorsque je clique sur le lien "modifier" la catégorie "cat2"
    Et je sélectionne "root" dans "Parent"
    Et je remplis "Nom" avec "cat2"
    Et je clique sur "Modifier"
    
    Alors je devrais voir "cat2" sur un niveau
    
    
  Scénario: Seul le rédacteur en chef voit l'onglet Catégorie
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Lorsque je vais sur la page des articles
    Alors je devrais voir l'onglet "Pages"
    Et je devrais voir l'onglet "Articles"
    Et je ne devrais pas voir l'onglet "Catégorie"
    
    Soit je suis identifié comme "publisher"    
    Lorsque je vais sur la page des articles
    Alors je devrais voir l'onglet "Pages"
    Et je devrais voir l'onglet "Articles"
    Et je ne devrais pas voir l'onglet "Catégorie"
    
    Soit je suis identifié comme "publisher-in-chief"    
    Lorsque je vais sur la page des articles
    Alors je devrais voir l'onglet "Pages"
    Et je devrais voir l'onglet "Articles"
    Et je devrais voir l'onglet "Catégorie"
    

  Scénario: Un rédacteur ne peut pas changer le statut d'un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"    
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | en cours  |
    
    Lorsque je suis sur la page des articles
    
    Alors je ne devrais pas voir "publier"
    Et je ne devrais pas voir "archiver"
    Et je ne devrais pas voir "Supprimer"
    
  Scénario: Un valideur peut changer le statut d'un article
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "publisher"
    Et les articles suivant dans la base:
     | titre            | status    |
     | premier article  | en cours  |
    
    Lorsque je suis sur la page des articles
    
    Alors je devrais voir "publier"
    Et je devrais voir "archiver"
    Et je devrais voir "supprimer"
    
  Scénario: un permalink doit être unique
    Soit le site est correctement configuré
    Et le site est en language "fr"
    Et je suis identifié comme "writer"
    Et les articles suivant dans la base:
     | titre            | date de création  |
     | premier article  | deux jours        |
     | premier article  | un jour           |

    Et je suis sur la page des articles

    Lorsque je clique sur le lien du dernier article crée

    Alors je devrais voir "premier-article2"
    