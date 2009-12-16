class Photo < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :photo, :styles => {
  		:mini =>  { :geometry => "40x40#",   :processors => [:cropper]},
  		:small => { :geometry => "100x100#", :processors => [:cropper]},
  		:large => { :geometry => "500x500>" }},
  	:url  => "/assets/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_photo, :if => :cropping?
	attr_protected :photo_file_name, :photo_content_type, :photo_size

  validates_presence_of :photo_file_name
  validates_uniqueness_of :photo_file_name

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

  def caption( japanese )
  	if japanese
  		caption_ja.blank? ? caption_en : caption_ja
  	else
  		caption_en.blank? ? caption_ja : caption_en
  	end
  end
  
private
  def reprocess_photo
    photo.reprocess!
  end
end
