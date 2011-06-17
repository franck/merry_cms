module Admin::Cms::CategoriesHelper
  
  def action_links(category, join_pattern="&nbsp;&nbsp;&nbsp;&nbsp;")
    links = []
    
    links << link_to(t('categories.edit_action'), edit_admin_cms_category_url(category))
    links << link_to(t('categories.delete_action'), admin_cms_category_url(category), :method => :delete, :confirm => t('categories.are_you_sure?'))
  
    links.join(join_pattern)
  end
  
  
end