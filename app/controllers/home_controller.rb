class HomeController < ApplicationController
  unloadable
  
	#caches_page :index
	
	layout "home"

	def index
		@categories = Category.find(:all)
	end
	
end
