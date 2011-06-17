module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /la page d'accueil/
      root_path
    when /la page d'inscription/
      signin_path
    when /la page d'activation$/
      register_path
    when /la page de mon compte/
      account_path
    when /la page d'identification/
      login_path
    when /la page de réinitialisation du mot de passe/
      new_password_reset_path
    when /la page de mise à jour du mot de passe/
      edit_password_reset_path
    when /la page d'administration des utilisateurs/
      admin_users_path
    when /la page de création d'un nouvel utilisateur/
      new_admin_user_path
    when /la page du cms/
      admin_cms_home_path
    when /la page des articles/
      admin_cms_articles_path
    when /la page de création d'un nouvel article/
      new_admin_cms_article_path
    when /la page de modification d'un article/
      edit_admin_cms_article_path
    when /la page qui affiche l'article/
      admin_cms_article_path
    when /la page des catégories/
      admin_cms_categories_path
    when /la page d'administration catégories/
      admin_cms_categories_path
    when /la page de création d'une catégorie/
      new_admin_cms_category_path
    when /la page de modification d'une catégorie/
      edit_admin_cms_category_path
    when /la page des médias/
      admin_assets_path
    when /la page de création d'un média/
      new_admin_asset_path
    when /la page de modification d'un média/
      edit_admin_asset_path
    when /la page des préférences/
      admin_site_settings_path
            
      
      
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

World(NavigationHelpers)