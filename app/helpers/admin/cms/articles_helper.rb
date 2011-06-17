module Admin::Cms::ArticlesHelper
  
  def events_links(article, join_pattern=", ")
    links = []
    if permit?("publisher publisher-in-chief admin")
      for event in article.aasm_events_for_current_state
        links << link_to(t('articles.events.' + event.to_s), method("#{event}_admin_cms_article_url").call(article))
      end
    end
    links.join(join_pattern)
  end
  
  
  def action_links(article, join_pattern="&nbsp;&nbsp;&nbsp;&nbsp;")
    links = []
    
    links << link_to(t('articles.edit_action'), edit_admin_cms_article_url(article))
    
    if permit?("publisher publisher-in-chief admin")
      for event in article.aasm_events_for_current_state
        links << link_to(t('articles.events.' + event.to_s), method("#{event}_admin_cms_article_url").call(article))
      end
      links << link_to(t('articles.destroy'), admin_cms_article_url(article), :method => :delete, :confirm => t('articles.are_you_sure?'))
    end
  
    links.join(join_pattern)
  end
  
  
  def get_states
    states = []
    states << [ t("articles.states.all"), "" ]
    Article.aasm_states.each do |s| 
      states << [ t("articles.states." + s.name.to_s), s.name.to_s ]
    end
    return states
  end
  
  def get_categories
    
    categories = nested_set_options(Category) {|i| "#{'–' * i.level} #{i.name}" }
    #categories.insert(0, [t("articles.none"), "nil"])
    categories.insert(0, [t("articles.all"), ""])
  end
  
end
