class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :record_not_founnd_error_message

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      new_item = user.items.create(item_params)
    else
      new_item = Item.create(item_params)
    end
    render json: new_item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def record_not_founnd_error_message 
    render json: { error: "Not found" }, status: :not_found
  end

end
