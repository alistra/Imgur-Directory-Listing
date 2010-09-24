class Image < ActiveRecord::Base
  
  include Imgur
  require 'mime/types'

  validates_presence_of :name
  validates_presence_of :imglink
  validates_presence_of :dellink
  validates_presence_of :large_thumb
  validates_presence_of :small_thumb

  validates_uniqueness_of :name
  validates_uniqueness_of :imglink
  validates_uniqueness_of :dellink
  validates_uniqueness_of :large_thumb
  validates_uniqueness_of :small_thumb
  
  def sendpic
    api_key = '27b25626f64a6a77fea07ec3ad2d5250'
    api = API.new(api_key)

    images_path = '/srv/www/'
    
    upload_info = api.upload_file("#{images_path}#{self.name}")

    self.imglink = upload_info['original_image']
    self.dellink = upload_info['delete_page']
    self.large_thumb = upload_info['large_thumbnail']
    self.small_thumb = upload_info['small_thumbnail']
  end

  def self.read_dir
    images_path = '/srv/www/'
    
    dbnames = Image.all.collect(&:name)
    dirnames = Dir.entries(images_path) - [".", ".."]

    to_upload = dirnames - dbnames
    puts "Uploading #{to_upload.size} files on imgur.com. It may take a while"
    to_upload.each {|x| in_create(x) if  has_image_mimetype?(images_path+x)}
    to_delete = dbnames - dirnames
    to_delete.each {|x| in_delete(x)}
  end
  
  def self.has_image_mimetype?(file)
    mimetypes = ["image/bmp", "image/gif", "image/jpeg", "image/png"]
    return mimetypes.include? MIME::Types.of(file).to_s
  end

  def self.in_create(filename)
    image = Image.new
    image.name = filename
    image.sendpic
    image.save
  end
 
  def self.in_delete(filename)
    image = Image.find_by_name(filename)
    image.destroy
  end
end
    

