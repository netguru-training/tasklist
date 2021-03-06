class ListsController < ApplicationController
  respond_to(:html)

  expose(:list_to_copy) { List.find(params[:id])}
  expose_decorated(:lists) { get_lists }
  expose_decorated(:list) { find_or_create_list }
  expose(:tags) { List.tags_with_weight }
  expose_decorated(:tasks) { list.tasks.decorate }
  expose_decorated(:task) { list.tasks.build }
  expose(:new_list) { list_to_copy.copied_list(current_user) }

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
    if list.save
      flash[:notice] = "List was successfully created."
    else
      flash[:alert] = "There was an error!"
    end
    respond_with(list)
  end

  # PATCH/PUT /lists/1
  def update
    if list.save
      flash[:notice] = "List was successfully updated."
    else
      flash[:alert] = "There was an error!"
    end
    respond_with(list)
  end

  # DELETE /lists/1
  def destroy
    if list.destroy
      flash[:notice] = "List was successfully destroyed."
    else
      flash[:alert] = "There was an error!"
    end
    redirect_to lists_path
  end

  def copy_and_paste
    if new_list.persisted?
      flash[:notice] = "List was successfully copied."
    else
      flash[:alert] = "There was an error!"
    end
    redirect_to new_list
  end

  def share_link
    url = "#{ root_url }shares/new?uuid=#{ list.uuid }"
    respond_to do |format|
      format.json { render :json => {:url => url } }
    end
  end

  def change_tag
    session[:active_tags] ||= []
    active_tags = session[:active_tags]
    tag_id = params[:tag_id]
    if tag_id
      if active_tags.include? tag_id
        active_tags.delete tag_id
      else
        session[:active_tags].push(params[:tag_id])
      end
    end
    session[:active_tags] = active_tags
    redirect_to lists_path
  end

  def copies
  end

  private
    def find_or_create_list
      list =
      if params[:id].present?
        List.find(params[:id])
      else
        current_user.lists.build
      end
      list.assign_attributes(list_params) if params[:list].present?
      list
    end

    def list_params
      params.require(:list).permit(:name, :description, :tags)
    end

    def get_lists
      active_tags = session[:active_tags]
      if active_tags and not active_tags.empty?
        current_user.all_lists_tagged(active_tags)
      else
        current_user.all_lists
      end
    end
end
