MerryMenu::Builder.configure do |config|
  config.menu :admin_menu do |m|
    m.tab 'admin.menu.cms', { :controller => "/admin/cms" }, "admin publisher-in-chief publisher writer"
    m.tab 'admin.menu.assets', { :controller => "/admin/assets"}, "admin publisher-in-chief publisher writer"
    m.tab 'admin.menu.site', { :controller => "/admin/site_settings" }, "admin", :class => "right"
    m.tab 'admin.menu.users', { :controller => "/admin/users" }, "admin", :class => "right"
  end
end

MerryMenu::Builder.configure do |config|
  config.menu :admin_submenu do |m|
    m.tab 'admin.menu.articles', { :controller => "admin/cms/articles" }, "admin publisher-in-chief publisher writer"
    m.tab 'admin.menu.categories', { :controller => "admin/cms/categories" }, "admin publisher-in-chief"
  end
end