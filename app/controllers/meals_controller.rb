class MealsController < ApplicationController

  def index
    if user_signed_in?
      @my_meals = current_user.hosted_meals.order(hosted_at: :desc)
      @friends_meals = current_user.guest_meals.order(hosted_at: :desc)
      @invites = current_user.invited_meals.order(hosted_at: :desc)
      @declined = current_user.declined_meals.order(hosted_at: :desc)
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      flash.keep[:notice] = "Your meal was created!"
      current_user.invites.create!(meal: @meal, role: 'host', invite_status: 'attending')
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    if user_signed_in?
      @meal = Meal.find(params[:id])
      @guests = @meal.attending_guests
      @dishes = @meal.dishes
      @invite = @meal.guest_invites.find_by(user_id: current_user)
      @comments = @meal.comments
      redirect_to root_path unless @invite.present?
    else
      redirect_to root_path
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash.keep[:notice] = "Meal Deleted"
    redirect_to root_path
  end

  private

  def meal_params
    params.require(:meal).permit(:title, :location, :hosted_at)
  end

end
