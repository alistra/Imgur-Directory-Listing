xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Images"
    xml.description "Alistra's images"
    xml.link images_url(:rss)
    
    for image in @images
      xml.item do
        xml.title image.name
        xml.description image_tag image.imglink
        xml.pubDate image.created_at.to_s(:rfc822)
        xml.link image_url(image)
        xml.guid image_url(image)
      end
    end
  end
end
