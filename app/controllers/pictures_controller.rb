class PicturesController < ApplicationController

  before_action :set_picture, only: %i[ show edit update destroy ]
  before_action :ensure_current_user, only: %i[ edit update destroy ]

  def index
    @pictures = Picture.all.order(id: "DESC").where.not(image: nil)
  end

  def show
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    render :new if params[:back]
    if @picture.save
      redirect_to pictures_path(@picture)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path(@picture)
    else
      format.html render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content, :user_id)
  end

  def ensure_current_user
    @picture = Picture.find(params[:id])
    unless @picture.user == current_user
      flash[:notice]="you don't have authority"
      redirect_to pictures_path
    end
  end
end
