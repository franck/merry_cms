class Admin::AssetsController < ApplicationController
  unloadable
  
  layout "admin"
    
  access_control do
    allow "writer"
    allow "publisher"
    allow "publisher-in-chief"
    allow "admin"
  end
  
  sortable_attributes :image_updated_at, :name, :image_file_size
  
  def index
    per_page = params[:per_page] || "10"
    @asset_tags = Asset.tag_list
    
    unless params[:view].nil?
      session[:view] = params[:view]
    end
    
    @assets = Asset.filter(per_page, params[:page], params[:filter], params[:asset_tag], sort_order(:default => "descending"))
    
    render :index, :layout => "gallery" if params[:layout] == "gallery"
  end
  
  def list
    @assets = Asset.find(:all, :order => "name asc", :limit => 200)
    array = @assets.map{|a| "[ \'#{a.name}\', \'#{a.image.url}\' ]" }.join(', ')
    myjs = "var tinyMCEImageList = new Array(#{array});"
    
    render :js => myjs
  end
  
  def gallery
    redirect_to "/admin/assets?layout=gallery"
  end
  
  
  def show
    @asset = Asset.find(params[:id])
    render :show, :layout => "gallery" if params[:layout] == "gallery"
  end
  
  def new
    @asset = Asset.new
    render :new, :layout => "gallery" if params[:layout] == "gallery"
  end
  
  def create
    @asset = Asset.new(params[:asset])
    
    if @asset.save
      flash[:notice] = t('assets.flash.asset_created')
      if params[:layout] == "gallery"
        redirect_to "/admin/assets?layout=gallery"
      else
        redirect_to :action => :index
      end
      
    else
      if params[:layout] == "gallery"
        render :new, :layout => "gallery"
      else
        render :new
      end
    end
  end
  
  def edit
    @asset = Asset.find(params[:id])
    render :edit, :layout => "gallery" if params[:layout] == "gallery"
  end
  
  def update
    @asset = Asset.find(params[:id])
    
    if @asset.update_attributes(params[:asset])
      flash[:notice] = t('assets.flash.asset_updated')
      if params[:layout] == "gallery"
        redirect_to "/admin/assets?layout=gallery"
      else
        redirect_to :action => :index
      end
    else
      if params[:layout] == "gallery"
        render :edit, :layout => "gallery"
      else
        render :edit
      end
    end
  end

  def destroy
    asset = Asset.find(params[:id])
    asset.destroy
    flash[:notice] = t('assets.flash.asset_deleted')
    if params[:layout] == "gallery"
      redirect_to "/admin/assets?layout=gallery"
    else
      redirect_to :action => :index
    end
  end
  
end
