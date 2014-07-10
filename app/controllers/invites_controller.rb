class InvitesController < ApplicationController

  def create
   @invite = Invite.new(invite_params)

    if @invite.save
      flash.now[:success] = "Invite sent!"
      redirect_to :back
    else
      flash.now[:alert] = "there was an error sending your invite"
    end
  end

  def update
    @invite = Invite.find(params[:id])
    if @invite.role == 'host'
      redirect_to meal_path(params[:meal_id]), notice: 'Host cannot change status'
    else
      @invite.invite_status = params[:invite_status]
      if @invite.save
        redirect_to meal_path(params[:meal_id])
      else
        flash.now[:alert] = 'there was an errors with your RSVP'
      end
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :meal_id, :role, :invite_status)
  end

end
