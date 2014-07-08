class UsersController < ApplicationController

  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      @users = User.all
    end
  end


end
