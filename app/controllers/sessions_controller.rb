class SessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:create, :login]
  def create
    auth = request.env["omniauth.auth"]
    user = begin
      User.find_by(uid: auth["uid"])
    rescue Mongoid::Errors::DocumentNotFound
      User.create_with_omniauth(auth)
    end

    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def login
    redirect_to lists_path if logged_in?
  end
end
