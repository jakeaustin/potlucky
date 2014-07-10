class UsermealsController < ApplicationController

  def create
   @usermeal = UserMeal.new(user_id: params[:user_id], meal_id: params[:meal_id], role: params[:role], invite_status: params[:invite_status])
  # @usermeal = UserMeal.new(usermeal_params)

    if @usermeal.save
      flash.now[:success] = "Invite sent!"
      redirect_to :back
    else
      flash.now[:alert] = "there was an error sending your invite"
    end
  end

  def update
    @usermeal = UserMeal.find(params[:id])
    if @usermeal.role == 'host'
      redirect_to meal_path(params[:meal_id]), notice: 'Host cannot change status'
    else
      @usermeal.invite_status = params[:invite_status]
      if @usermeal.save
        redirect_to meal_path(params[:meal_id])
      else
        flash.now[:alert] = 'there was an errors with your RSVP'
      end
    end
  end

  private

  def usermeal_params
    params.require(:user_meal).permit(:user_id, :meal_id, :role, :invite_status)
  end

end
