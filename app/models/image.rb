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

    upload_info = api.upload_file("#{IMAGES_PATH}#{self.name}")
  
    self.refresh = 0
    self.imglink = upload_info['original_image']
    self.dellink = upload_info['delete_page']
    self.large_thumb = upload_info['large_thumbnail']
    self.small_thumb = upload_info['small_thumbnail']
  end

  def self.find_dead_links
    count = 0
    tempfile = `mktemp`

    images = Image.all.reject{|x| x.refresh == true }
    max_count = images.size 

    images.each do |x|
      count += 1
      puts "#{count}/#{max_count}"
      begin
        rio(x.imglink) > rio(tempfile)
        md5sum_output = `md5sum #{tempfile}`
        if md5sum_output =~ /4c1548f851616c6713475622c850c81e/
          x.refresh = 1
          x.save
        end
      rescue 
        puts $!
        x.refresh = 1
        x.save
      end
    end

    `rm #{tempfile}`
  end

  def self.refresh_dead_links
    count = 0
    images = Image.all.reject{|x| x.refresh == false}
    max_count = images.size
    images.each do |x| 
      count += 1
      puts "#{count}/#{max_count}"
      x.sendpic
      x.refresh = false
      x.save
    end
  end

  def self.read_dir
    dbnames = Image.all.collect(&:name)
    dirnames = Dir.entries(IMAGES_PATH) - [".", ".."]

    to_upload = dirnames - dbnames
    to_upload.reject! {|x| !has_image_mimetype?(IMAGES_PATH+x)} 
    puts "Uploading #{to_upload.size} files on imgur.com. It may take a while" if to_upload.size > 1 
    to_upload.each {|x| in_create(x)}
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
