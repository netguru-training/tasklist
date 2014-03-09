class SharesController < ApplicationController
  expose(:uuid) { params[:uuid] }
  expose(:list) { List.find_by(uuid: params[:uuid]) }
  def create
    unless current_user.all_lists.include? list
      Share.create user: current_user, list: list
    end
    redirect_to list
  end

  def new
  end
end
