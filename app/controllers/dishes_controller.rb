class DishesController < ApplicationController

  def new
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.new
  end

  def create
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.new(dish_params)
    @dish.claimer_id = @meal.host_invite.id
    @dish.meal_id = @meal.id

    if @dish.save
      flash.keep[:notice] = "Dish added to meal"
      redirect_to meal_path(@meal)
    else
      flash.keep[:notice] = "There was an error adding your dish"
      render :new
    end
  end

  def show
    @dish = Dish.find(params[:id])
    @meal = Meal.find(params[:meal_id])
    @host = @meal.host_invite
    @claimer = Invite.find(@dish.claimer_id)
    @current_guest = current_user.invites.find_by(meal_id: @meal.id)
  end

  def update
    @dish = Dish.find(params[:id])
    @meal = Meal.find(params[:meal_id])
    @dish.can_be_claimed = params[:can_be_claimed]
    @dish.claimer_id = params[:claimer_id]

    if @dish.save
      flash.keep[:notice] = "Responsibility for dish updated"
      redirect_to meal_path(@meal)
    else
      flash.keep[:notice] = "There was an error updating dish responsibility"
      redirect_to meal_path(@meal)
    end
  end

  def destroy
    @meal = Meal.find(params[:meal_id])
    @dish = Dish.find(params[:id])
    @dish.destroy
    flash.keep[:notice] = "Dish deleted"
    redirect_to meal_path(@meal)
  end

  def search
    @meal = Meal.find(params[:meal_id])

    @results = Rails.cache.fetch(['yummlySearch', params[:search_term]], expires_in: 5.minutes) do
      Yummly.search(params[:search_term])
    end

    @banner = @results.attribution.html

    @matches = Rails.cache.fetch(['yummlyResult', params[:search_term]], expires_in: 5.minutes) do
      @results.matches.map do |matched|
      match = Yummly.find(matched['id'])
      subset = {
                name: match.name,
                thumb: match.thumbnail,
                ingr: match.ingredients,
                rate: match.rating,
                link: match.attribution.url
               }
      end
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:search_term, :name, :thumb_url, :recipe_url, :claimer_id, :meal_id, :can_be_claimed)
  end

end
