class ListController < ApplicationController

  get '/lists' do
    @user = current_user
    @user_lists = current_user.lists.uniq.sort_by {|list| list.name}
    erb :'lists/index'
  end

  get '/lists/new' do
    if logged_in?
      @user = current_user
      erb :'lists/create'
    else
      redirect to '/users/login'
    end
  end

  post '/lists/new' do
    if params[:list][:name] != ""
      list = List.create(name: params[:list][:name], user_id: params[:list][:user_id])
      list.save
      if list.name == "Shopping List"
        current_user.items.each do |item|
          if item.condition_status == "Needs Replacement"
            new_item = ListItem.create(item_id: item.id, list_id: list.id)
            list.list_items << new_item
          end
        end
      elsif list.name == "Cleaning List"
        current_user.items.each do |item|
          if item.condition_status == "Needs Cleaning"
            new_item = ListItem.create(item_id: item.id, list_id: list.id)
            list.list_items << new_item
          end
        end
      elsif list.name == "Repair List"
        if item.condition_status == "Needs Repair"
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end

    elsif params[:list][:name] == nil && params[:list_name] != ""
      list = List.create(name: params[:list_name], user_id: params[:list][:user_id])
    else
      redirect to '/lists/new'
    end
    redirect to '/lists/edit'
  end

  get '/lists/:id' do
    @list = List.find_by(id: params[:id])
    @user = current_user
    if logged_in? && @user.lists.include?(@list)
      erb :'lists/show'
    else
      redirect to '/users/login'
    end
  end

  get '/lists/:id/edit' do
    @list = List.find_by(id: params[:id])
    @user = current_user
    if logged_in? && @user.lists.include?(@list)
      erb :'lists/edit'
    else
      redirect to '/users/login'
    end
  end
end
