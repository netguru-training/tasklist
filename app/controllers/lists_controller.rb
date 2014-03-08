class ListsController < ApplicationController
  respond_to(:html)

  expose(:list_to_copy) { List.find(params[:id])}
  expose(:lists) { current_user.lists }
  expose(:list) { find_or_create_list }
  expose(:tags) { List.tags_with_weight }
  expose_decorated(:tasks) { list.tasks.decorate }

  # GET /lists
  def index
  end

  # GET /lists/1
  def show
  end

  # GET /lists/new
  def new
    list.user = current_user
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

  def copy_and_paste
    new_list = list_to_copy.copied_list(current_user._id)
    redirect_to new_list
  end

  def share_link
    url = root_url + 'share/' + list.uuid
    respond_to do |format|
      format.html
      format.json { respond_with text: url }
    end
  end

  private
    def find_or_create_list
      if params[:id]
        current_user.lists.find(params[:id])
      elsif params[:list]
        current_user.lists.new(list_params)
      else
        current_user.lists.new
      end
    end

    def list_params
      params.require(:list).permit(:name, :description, :tags)
    end
end
