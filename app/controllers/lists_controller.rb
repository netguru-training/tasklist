class ListsController < ApplicationController
  respond_to(:html)
  expose(:lists) { List.all }
  expose(:list, attributes: :list_params)
  expose(:tags) { List.tags_with_weight }
  expose(:tasks)

  # GET /lists
  def index
  end

  # GET /lists/1
  def show
  end

  # GET /lists/new
  def new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  def create
    list.save
    respond_with(list)
  end

  # PATCH/PUT /lists/1
  def update
    list.save
    respond_with(list)
  end

  # DELETE /lists/1
  def destroy
    list.destroy
    respond_with(list)
  end

  private
    def list_params
      params.require(:list).permit(:name, :description, :tags)
    end
end
