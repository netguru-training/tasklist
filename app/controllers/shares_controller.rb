class SharesController < ApplicationController
  def create
    list = List.find(uuid: params[:uuid])
    Share.create user: current_user, list: list
  end
end
