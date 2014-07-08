class UsermealsController < ApplicationController

  def create
    @usermeal = UserMeal.new(user_id: params[:user_id], meal_id: params[:meal_id], role: params[:role], invite_status: params[:invite_status])

    if @usermeal.save
      flash.now[:success] = "Invite sent!"
      redirect_to :back
    else
      flash.now[:alert] = "there was an error sending your invite"
    end
  end

  def update
  end

end
