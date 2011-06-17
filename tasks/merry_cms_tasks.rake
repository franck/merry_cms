namespace :merry do
  
  desc 'cms init'
  task :bootstrap => [
   	:create_admin_user,
   	:create_site,
   	:create_category_root
  ]
  
  desc 'cms update'
  task :update => [
    :plugins,
    :migration,
    :asset,
    :config,
    :locales,
    :initializer,
    :test
  ]
  
  desc 'cms update all (even risky models and controllers)'
  task :update_all => [
    :update,
    :user_auth_models,
    :user_auth_controllers,
    :application
  ]
  
  desc 'cms update public part'
  task :public => [
    :home_public,
    :user_public
  ]
  
  desc 'Create the administrator super-user'
  task :create_admin_user => :environment do
    unless User.find_by_email("admin@test.fr")  
      # password is mypassword
      #user = Factory.build(:user, :email => "admin@test.fr")
      user = User.new(:email => "admin@test.fr", :password => "admin")
      user.activate
      user.save
      user.has_role!('admin')
      raise "Couldn't save administrator!" if !user.save_without_session_maintenance
    else
      puts "INFO : Admin user already present"
    end
  end
  
  desc 'Create site'
  task :create_site => :environment do
    unless SiteSetting.count > 0
      puts "Creating site ..."
      SiteSetting.create(:title => "Defaut title")
    else
      puts "INFO : Site already present"
    end
  end
  
  desc 'Create Category Root'
  task :create_category_root => :environment do
    unless Category.count > 0
      puts "Creating category Root ..."
      Category.create(:name => "root")
    else
      puts "INFO : Category root already present"
    end
  end
  
  desc 'Install plugins'
  task :plugins => :environment do  
    plugins = {
      "franck_acl9" => "git://github.com/franck/acl9.git",
      "acts_as_taggable_on" => "git://github.com/mbleigh/acts-as-taggable-on.git",
      "authlogic" => "git://github.com/binarylogic/authlogic.git",
      "asset_packager" => "git://github.com/sbecker/asset_packager.git",
      "awesome_nested_set" => "git://github.com/collectiveidea/awesome_nested_set.git",
      "franck_globalize2" => "git://github.com/franck/globalize2.git",
      "gravatar" => "git://github.com/woods/gravatar-plugin.git",
      "languages_switch" => "git://github.com/franck/languages_switch.git",
      "merry_error_messages_for" => "git://github.com/franck/merry_error_messages_for.git",
      "merry_menu" => "git://github.com/franck/merry_menu.git",
      "meta_tags" => "git://github.com/kpumuk/meta-tags.git",
      "paperclip" => "git://github.com/thoughtbot/paperclip.git",
      "permalink_fu" => "git://github.com/technoweenie/permalink_fu.git",
      "resource_fu" => "git://github.com/infused/resource_fu.git",
      "sortable_table" => "git://github.com/thoughtbot/sortable_table.git",
      "squirrel" => "git://github.com/thoughtbot/squirrel.git",
      "tiny_mce" => "git://github.com/kete/tiny_mce.git",
      "will_paginate" => "git://github.com/mislav/will_paginate.git"
    }   
    
    plugins.each do |plugin, path| 
      puts "installing #{plugin} ..." 
      system "git submodule add #{path} vendor/plugins/#{plugin}"
    end
  end
  
  desc "Sync migrations"
  task :migration => :environment do
    puts "****** Syncing migration files ******"
    system "rsync -ruv vendor/plugins/merry_cms/db/migrate db"
  end
  
  desc "Sync home controller and views"
  task :home_public => :environment do
    puts "****** Syncing home controller and views files ******"
    system "rsync -v --inplace vendor/plugins/merry_cms/app/controllers/home_controller.rb app/controllers"
    system "rsync -ruv vendor/plugins/merry_cms/app/views/home app/views"
    system "rsync -v --inplace vendor/plugins/merry_cms/app/views/layouts/home.html.erb app/views/layouts"
  end
  
  desc "Sync user views"
  task :user_public => :environment do
    puts "****** Syncing migration files ******"  
    system "rsync -ruv vendor/plugins/merry_cms/app/views/users app/views"
  end
  
  desc "Sync user auth models"
  task :user_auth_models => :environment do
    puts "****** Syncing user_auth_models files ******"
    system "rsync -v --inplace vendor/plugins/merry_cms/lib/user_auth_models/* app/models"
  end
  
  desc "Sync user auth controllers"
  task :user_auth_controllers => :environment do
    puts "****** Syncing user_auth_controllers files ******"
    system "rsync -v --inplace vendor/plugins/merry_cms/lib/user_auth_controllers/* app/controllers"
  end
  
  desc "Sync assets"
  task :asset => :environment do
    puts "****** Syncing assets files ******"
    system "rsync -ruv vendor/plugins/merry_cms/public ./"
  end
  
  desc "Sync config"
  task :config => [ :locales, :initializer ] do
    system "rsync -ruv vendor/plugins/merry_cms/config/app_config.yml config"
    system "rsync -ruv vendor/plugins/merry_cms/config/asset_packages.yml config"
  end
  
  desc "Sync locales"
  task :locales => :environment do
    puts "****** Syncing locales files ******"
    system "rsync -ruv vendor/plugins/merry_cms/config/locales config"
  end
  
  desc "Sync initializers"
  task :initializer => :environment do
    puts "****** Syncing initializers files ******"
    system "rsync -ruv vendor/plugins/merry_cms/config/initializers config"
  end
  
  desc "Sync application files"
  task :application => :environment do
    puts "****** Syncing application files ******"
    system "rsync -v --inplace vendor/plugins/merry_cms/app/controllers/application_controller.rb app/controllers"
    system "rsync -v --inplace vendor/plugins/merry_cms/app/helpers/application_helper.rb app/helpers"
  end
  
  desc "Sync features files"
  task :test => :environment do
    puts "****** Syncing application files ******"
    system "rsync -ruv vendor/plugins/merry_cms/features ./"
    system "rsync -ruv vendor/plugins/merry_cms/test/factories test"
  end
  
  desc 'Translate old articles and categories'
  task :translate => [
   	:translate_articles,
   	:translate_categories
  ]
  
  desc 'Migrate old articles to translated articles'
  task :translate_articles => :environment do
    puts "Number of articles : " + Article.count.to_s
    puts "Translating old articles ..."
    
    sql = "select id,title,intro,content,permalink from articles;"
    articles = ActiveRecord::Base.connection.select_rows(sql)
    
    for article in articles do
      puts "Translating article : " + article[1]
      # puts "ID : " + article[0]
      # puts "Title : " + article[1]
      # puts "Intro : " + article[2]
      # puts "Content : " + article[3]
      # puts "Permalink : " + article[4]
      # puts "********************************************************"
      
      article_translated = Article.find(article[0])
      
      article_translated.title = article[1]
      article_translated.intro = article[2]
      article_translated.content = article[3]
      
      article_translated.save      
    end     
  end
  
  desc 'Migrate old categories to translated categories'
  task :translate_categories => :environment do
    puts "Number of categories : " + Category.count.to_s
    puts "Translating old categories ..."
    
    sql = "select id,name,permalink from categories;"
    categories = ActiveRecord::Base.connection.select_rows(sql)
    
    for category in categories do
      puts "Translating category : " + category[1]
      # puts "ID : " + article[0]
      # puts "Title : " + article[1]
      # puts "Intro : " + article[2]
      # puts "Content : " + article[3]
      # puts "Permalink : " + article[4]
      # puts "********************************************************"
      
      category_translated = Category.find(category[0])
      category_translated.name = category[1]
      category_translated.save      
    end     
  end
  
end