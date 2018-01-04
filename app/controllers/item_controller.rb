class ItemController < ApplicationController

  get '/items' do
    if logged_in?
      @user = current_user
      @user_items = current_user.items.sort_by {|item| item.name}
      erb :'items/index'
    else
      redirect to '/users/login'
    end
  end

  get '/items/new' do
    if logged_in?
      @user = current_user
      @locations = Location.all.select {|location| location.admin_lock || @user.locations.include?(location)}
      @categories = Category.all.select {|category| category.admin_lock || @user.categories.include?(category)}
      erb :'items/create'
    else
      redirect to '/users/login'
    end
  end

  post '/items/new' do
    item = Item.create(params[:item])
    if params[:item_location] != ""
      new_location = Location.create(name: params[:item_location], admin_lock: false)
      item.location_id = new_location.id
    end

    if params[:item_category] != ""
      new_category = Category.create(name: params[:item_category], admin_lock: false)
      item.category_id = new_category.id
    end

    item.info_complete = true
    item.save
    item.attributes.each do |attr|
      if attr.blank?
        item.info_complete = false
      end
    end

    item.save
    redirect to '/items'
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
    @user = current_user
    @locations = Location.all.select {|location| location.admin_lock || @user.locations.include?(location)}
    @categories = Category.all.select {|category| category.admin_lock || @user.categories.include?(category)}
    @item = Item.find_by(id: params[:id])
    if logged_in? && @item.user_id == current_user.id
      erb :'items/edit'
    else
      redirect to '/users/login'
    end
  end

  post '/items/:id/edit' do
    item = Item.find_by(id: params[:id])
    item.update(params[:item])
    if params[:item_location] != ""
      new_location = Location.create(name: params[:item_location], admin_lock: false)
      item.location_id = new_location.id
    end

    if params[:item_category] != ""
      new_category = Category.create(name: params[:item_category], admin_lock: false)
      item.category_id = new_category.id
    end

    item.info_complete = true
    item.save
    item.attributes.each do |k, v|
      if item[k] == nil || item[k] == "" || item[k] == " "
        item.info_complete = false
      end
    end

    item.save
    redirect to "/items/#{item.id}"
  end

end
