module ApplicationHelper
  
  include SortableTable::App::Helpers::ApplicationHelper
  include Acl9Helpers
  
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

	def title(page_title)
		@content_for_title = page_title.to_s
	end
	
	def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              id="clippy"
              title=#{t('image.copy')} >
      <param name="movie" value="/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/flash/clippy.swf"
             width="16"
             height="16"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
  
  access_control :show_private? do
    allow "admin"
    allow "writer"
    allow "publisher"
    allow "publisher-in-chief"
  end
  
  access_control :edit_article? do
    allow "admin"
    allow "writer"
    allow "publisher"
    allow "publisher-in-chief"
  end
  
  access_control :edit_offer? do
    allow "admin"
    allow "offer", :except => [:publish, :unpublish, :archive, :unarchive, :destroy]
    allow "offer-in-chief"
  end
  
  
  def breadcrumbs_category(category, site="Site")    
    return if category.nil?
    cat = []
    cat = category.ancestors.collect {|c| c }
    cat.reject! {|c| c.permalink == "root" }
    html = ""
    html << "<div id='breadcrumbs'>"
    html << "#{link_to site, '/' }"
    html << "&nbsp;>&nbsp;"
    if cat.size > 0
    html << cat.collect {|c| link_to c.name, public_category_url(c) }.join('&nbsp;>&nbsp;')
    html << "&nbsp;>&nbsp;"
    end
    html << category.name.capitalize
    html << "</div>"
  end

  def breadcrumbs_article(article, site="Site")   
    return if article.nil?
    category = []
    category = article.category.ancestors.collect {|c| c }
    category << article.category
    category.reject! {|c| c.permalink == "root" }
    html = ""
    html << "<div id='breadcrumbs'>"
    html << "#{link_to site, '/' }"
    html << "&nbsp;>&nbsp;"
    if category.size > 0
      html << category.collect {|c| link_to c.name, public_category_url(c) }.join('&nbsp;>&nbsp;')
      html << "&nbsp;>&nbsp;"
    end
    html << article.title.capitalize
    html << "</div>"
  end
  
  def infos_breadcrumbs_category(category, site="Site")    
    return if category.nil?
    cat = []
    cat = category.ancestors.collect {|c| c }
    cat.reject! {|c| c.permalink == "root" }
    cat.reject! {|c| c.permalink == "infos-candidats-coaching" }
    html = ""
    html << "<div id='breadcrumbs'>"
    html << "#{link_to site, '/infos' }"
    html << "&nbsp;>&nbsp;"
    if cat.size > 0
    html << cat.collect {|c| link_to c.name, public_category_url(c) }.join('&nbsp;>&nbsp;')
    html << "&nbsp;>&nbsp;"
    end
    html << category.name.capitalize
    html << "</div>"
  end

  def infos_breadcrumbs_article(article, site="Site")   
    return if article.nil?
    category = []
    category = article.category.ancestors.collect {|c| c }
    category << article.category
    category.flatten!
    category.reject! {|c| c.permalink == "root" }
    category.reject! {|c| c.permalink == "infos-candidats-coaching" }
    html = ""
    html << "<div id='breadcrumbs'>"
    html << "#{link_to site, '/infos' }"
    html << "&nbsp;>&nbsp;"
    if category.size > 0
      html << category.collect {|c| link_to c.name, public_category_url(c) }.join('&nbsp;>&nbsp;')
      html << "&nbsp;>&nbsp;"
    end
    html << article.title.capitalize
    html << "</div>"
  end
  
  def format_nested_set(item_or_items, first=true, options = {}, &block)
    options.reverse_merge!({
      :major => {:tag => :ul, :class => 'tree'},
      :minor => {:tag => :li, :class => "test"}
    })

    item_or_items = Array(item_or_items)

    content = ''
    return content if item_or_items.empty?

    item_or_items.each do |i|

      unless first
        link = link_to i.name, public_category_url(i)
        minor_content = content_tag("li", link, :class => "cat")
      else
        minor_content = ""
      end
      
      articles = i.articles.select{|a| a.state == "published" } 
      unless articles.size == 0
        articles.each do |article|
          link = link_to article.title, public_article_url(article)
          minor_content += content_tag("li", link, :class => "article")
        end
      end
      
      minor_content << format_nested_set(i.children, false, options, &block)
      content << minor_content
    end
    
    if first
      content_tag("ul", content, :class => "root")
    else
      content_tag("ul", content, :class => options[:major][:class])
    end
  end

  def public_article_url(article)
    return if article.nil? or article.permalink.nil?
    id = article.id.to_s + "-" + article.permalink
    url_for(:controller => "articles", :action => "show", :id => id, :locale => I18n.locale)
  end
  
  def public_category_url(category)
    return if category.nil? or category.permalink.nil?
    id = category.id.to_s + "-" + category.permalink
    url_for(:controller => "categories", :action => "show", :id => id, :locale => I18n.locale)
  end
  
  def intro_or_excerpt(article)
    if article.intro.blank?
      truncate_html(article.content, :length => 300)
    else
      article.intro
    end
  end
  	
end