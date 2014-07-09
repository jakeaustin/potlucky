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
    @usermeal = UserMeal.find(params[:id])
    @usermeal.invite_status = params[:invite_status]
    if @usermeal.save
      redirect_to meals_path(:meal_id)
    else
      flash.now[:alert] = 'there was an errors with your RSVP'
    end
  end

end