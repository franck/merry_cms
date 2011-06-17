class Asset < ActiveRecord::Base
  
  #has_attached_file :image, :styles => { :small => ["100x100", :png] }
  
  has_attached_file :image, :styles => { :small => ["100x100", :png] },
                            :processors => lambda { |a| a.video? ? [ :video_thumbnail ] : [ :thumbnail ] },
                            :whiny => false
  
  validates_presence_of :name, :message => I18n.t("assets.error_messages.name_cant_be_blank")  
  validates_attachment_presence :image, :message => I18n.t("assets.error_messages.image_cant_be_blank")  
  validates_attachment_size :image, :less_than => 10.megabytes, :message => I18n.t("assets.error_messages.image_less_than_5M")  

  acts_as_taggable_on :asset_tags
  
  def self.filter(per_page="10", page=1, filter="", asset_tag="", order="")    
    options = { :per_page => per_page, :page => page }
    
    results = find :all do
      all do
        any do
          name =~ "%#{filter}%"
          image_file_name =~ "%#{filter}%"
        end
      end
      order_by order
    end
    
    unless asset_tag.blank?
      results.collect!{|a| a if a.asset_tag_list.include? asset_tag}.compact!
    end
    
    results.paginate(options)
    
  end

  def self.tag_list
    self.asset_tag_counts.sort{|k,y| k.name <=> y.name }
  end
  
  def image?
    image.content_type =~ /image/
  end
  
  def video?
        
      [ 'application/x-mp4',
        'video/mpeg',
        'video/x-m4v',
        'video/quicktime',
        'video/x-la-asf',
        'video/x-ms-asf',
        'video/x-msvideo',
        'video/x-sgi-movie',
        'video/x-flv',
        'flv-application/octet-stream',
        'video/3gpp',
        'video/3gpp2',
        'video/3gpp-tt',
        'video/BMPEG',
        'video/BT656',
        'video/CelB',
        'video/DV',
        'video/H261',
        'video/H263',
        'video/H263-1998',
        'video/H263-2000',
        'video/H264',
        'video/JPEG',
        'video/MJ2',
        'video/MP1S',
        'video/MP2P',
        'video/MP2T',
        'video/mp4',
        'video/MP4V-ES',
        'video/MPV',
        'video/mpeg4',
        'video/mpeg4-generic',
        'video/nv',
        'video/parityfec',
        'video/pointer',
        'video/raw',
        'video/rtx' ].include?(image.content_type)
    end

  
end
