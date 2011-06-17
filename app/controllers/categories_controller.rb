class CategoriesController < ApplicationController
  unloadable
  
	#caches_page :index
	#caches_page :show

	layout "home"

	def index
	end

	def show	
		@category = Category.find(params[:id])
 		@articles = @category.articles
		
		unless @category.nil?
			@page_title = @category.name
		end
	end
		

end