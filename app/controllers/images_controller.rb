class ImagesController < ApplicationController
  def index
    @images = Image.all
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
