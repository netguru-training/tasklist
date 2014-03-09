class SharesController < ApplicationController
  expose(:uuid) { params[:uuid] }
  def create
    list = List.find_by(uuid: params[:uuid])
    unless current_user.all_lists.include? list
      Share.create user: current_user, list: list
    end
    redirect_to list
  end

  def new
  end
end
