class InvitesController < ApplicationController

  def create
   @invite = Invite.new(invite_params)

    if @invite.save!
      flash.now[:success] = "Invite sent!"
      redirect_to :back
    end
  end

  def update
    @invite = Invite.find(params[:id])
    if @invite.role == 'host'
      flash.keep[:notice] = "Host cannot change status"
      redirect_to meal_path(params[:meal_id])
    else
      @invite.invite_status = params[:invite_status]
      if @invite.save!
        redirect_to meal_path(params[:meal_id])
      end
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:user_id, :meal_id, :role, :invite_status)
  end

end
