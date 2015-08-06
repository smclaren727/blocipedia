class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
		authorize @wikis
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
		@wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki entry was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the entry. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
      flash[:notice] = "Wiki entry was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the entry. Please try again."
      render :edit
    end
  end

  def destroy
   @wiki = Wiki.find(params[:id])
   authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error deleting the entry."
      render :show
    end
  end
  
end
