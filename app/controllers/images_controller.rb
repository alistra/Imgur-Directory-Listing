class ImagesController < ApplicationController
  def index
    @images = Image.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 40
  end

  def show
    @image = Image.find(params[:id])
    redirect_to @image.imglink
  end

  def search
    images = Image.all(:conditions => ["name like ?", params[:partial]+"%"])
    @image = images[rand(images.size)]
    redirect_to @image.imglink
  end
end
