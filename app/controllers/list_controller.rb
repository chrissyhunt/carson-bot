class ListController < ApplicationController

  get '/lists' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    @user_lists = current_user.lists.uniq.sort_by {|list| list.name}
    erb :'lists/index'
  end

  get '/lists/new' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    erb :'lists/create'
  end

  post '/lists/new' do
    if !logged_in?
      redirect to '/users/login'
    end

    if params[:list][:name] == "" || params[:list][:name] == " " || params[:list][:name].blank?
      if params[:list_name] == "" || params[:list_name] == " " || params[:list_name].blank?
        flash[:message] = "Your list needs a name."
        redirect to '/lists/new'
      end
    end

    if params[:list][:name] != "" || params[:list][:name] != " " || !params[:list][:name].blank?
      list = List.find_or_create_by(name: params[:list][:name], user_id: params[:list][:user_id])
    elsif params[:list_name] != "" || params[:list_name] != " " || !params[:list_name].blank?
      list = List.find_or_create_by(name: params[:list_name], user_id: params[:list][:user_id])
    end

    list.save

    if list.name == "Shopping List"
      current_user.items.each do |item|
        if item.condition_status == "Needs Replacement" || item.expired?
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
    end

    if list.name == "Cleaning List"
      current_user.items.each do |item|
        if item.condition_status == "Needs Cleaning"
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
    end

    if list.name == "Repair List"
      current_user.items.each do |item|
        if item.condition_status == "Needs Repair"
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
    end

    if list.name == "Incomplete Item Records"
      current_user.items.each do |item|
        if item.info_incomplete?
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
    end

    if list.name == "Expired Documents"
      current_user.items.each do |item|
        if item.category.name == "Document" && item.expired?
          new_item = ListItem.create(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
    end

    list.save
    redirect to "/lists/#{list.id}/edit"
  end

  post '/lists/:id/update' do
    list = List.find_by(id: params[:id])

    if !current_user.lists.include?(list)
      redirect to '/lists'
    end

    if list.name == "Shopping List"
      list.items.clear
      current_user.items.each do |item|
        if item.condition_status == "Needs Replacement" || item.expired?
          new_item = ListItem.find_or_create_by(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
      list.save
      redirect to "/lists/#{list.id}/edit"
    end

    if list.name == "Cleaning List"
      list.items.clear
      current_user.items.each do |item|
        if item.condition_status == "Needs Cleaning"
          new_item = ListItem.find_or_create_by(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
      list.save
      redirect to "/lists/#{list.id}/edit"
    end

    if list.name == "Incomplete Item Records"
      list.items.clear
      current_user.items.each do |item|
        if item.info_incomplete?
          new_item = ListItem.find_or_create_by(item_id: item.id, list_id: list.id)
          list.list_items << new_item
        end
      end
      list.save
      redirect to "/lists/#{list.id}/edit"
    end

    if list.name == "Expired Documents"
      list.items.clear
      current_user.items.each do |item|
        if item.category.name == "Document" && item.expired?
          new_item = ListItem.find_or_create_by(item_id: list.id, list_id: list.id)
          list.list_items << new_item
        end
      end
      list.save
      redirect to "/lists/#{list.id}/edit"
    end
  end

  get '/lists/:id' do
    if !logged_in?
      redirect to '/users/login'
    end

    @list = List.find_by(id: params[:id])
    @user = current_user

    if @user.lists.include?(@list)
      erb :'lists/show'
    else
      redirect to '/lists'
    end
  end

  get '/lists/:id/edit' do
    if !logged_in?
      redirect to '/users/login'
    end

    @list = List.find_by(id: params[:id])
    @user = current_user
    @user_items = current_user.items.sort_by {|item| item.name}

    if @user.lists.include?(@list)
      erb :'lists/edit'
    else
      redirect to '/lists'
    end
  end

  post '/lists/:id/edit' do
    list = List.find_by(id: params[:id])

    if params[:list_name] != ""
      list.name = params[:list_name]
      list.save
    else
      flash[:message] = "Your list needs a name."
      redirect to "lists/#{list.id}/edit"
    end

    if params[:list_item] && !params[:list_item][:item_id].empty?
      list.items.clear
      params[:list_item][:item_id].each {|item_id| list.items << Item.find_by(id: item_id)}
      list.save
    else
      list.delete
      redirect to '/lists'
    end

    redirect to "/lists/#{list.id}"
  end

  delete '/lists/:id/delete' do
    if !logged_in?
      redirect to '/users/login'
    end

    list = List.find_by(id: params[:id])

    if list.user_id == current_user.id
      list.delete
    end
    redirect to '/lists'
  end
end
