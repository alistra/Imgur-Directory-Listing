class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
    redirect_to @image.imglink
  end

  def search
    @images = Image.find_by_name(:partial)
end
