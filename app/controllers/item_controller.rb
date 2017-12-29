class ItemController < ApplicationController

  get '/items' do
    if logged_in?
      @user = current_user
      @items = current_user.items
      erb :'items/index'
    else
      redirect to '/users/login'
    end
  end

  get '/items/new' do
    if logged_in?
      @user = current_user
      erb :'items/create'
    else
      redirect to '/users/login'
    end
  end

  get '/items/:id' do
    if logged_in?
      @user = current_user
      @item = Item.find_by(id: params[:id])
      erb :'items/show'
    else
      redirect to '/users/login'
    end
  end

  get '/items/:id/edit' do
    @item = Item.find_by(id: params[:id])
    if logged_in? && @item.user_id == current_user.id
      erb :'items/edit'
    else
      redirect to '/users/login'
    end
  end

end
