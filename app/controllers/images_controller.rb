class ImagesController < ApplicationController
  def index
    @images = Image.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 100
  end

  def show
    @image = Image.find(params[:id])
    redirect_to @image.imglink
  end

  def search
    @image = Image.first(:conditions => ["name like ?", params[:partial]+"%"])
    redirect_to @image.imglink
  end
end
