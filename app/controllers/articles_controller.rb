class ArticlesController < ApplicationController
  unloadable

	#caches_page :show
  
  layout "home"
  
  def show    
    @article = Article.find(params[:id], :conditions => "state = 'published'")	
    
		unless @article.nil?
    	@page_title = @article.title
		end
  end

end
