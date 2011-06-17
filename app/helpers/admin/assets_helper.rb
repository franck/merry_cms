module Admin::AssetsHelper
  
  def display_asset_preview(asset)
    case asset.image.url
    when /\.xls/
      "/images/big_xls.png"
    when /\.doc/
      "/images/big_doc.png"
    when /\.txt/
      "/images/big_txt.png"
    when /\.ppt/
      "/images/big_ppt.png"
    else
      asset.image.url(:small)
    end
  end
  
  
  def display_small_asset_preview(asset)
    case asset.image.url + asset.image.content_type
    when /\.(png|gif|jpg|jpeg|tiff|JPEG|JPG|PNG|GIF)/
      "/images/image.png"
    when /\.pdf/
      "/images/pdf.png"
    when /\.xls/
      "/images/xls.png"
    when /\.doc/
      "/images/doc.png"
    when /\.ppt/
      "/images/ppt.png"
    when /\.txt/
      "/images/txt.png"
    when /video\//
      "/images/film.png"
    else
      "/images/page_white.png"
    end
  end
  
  def back_to_index_link
    if params[:layout] == "gallery"
      link_to t('cancel'), gallery_admin_assets_url
    else
      link_to t('cancel'), admin_assets_url
    end
  end
  
end
