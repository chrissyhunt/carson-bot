class ListController < ApplicationController

  get '/lists' do
    @user = current_user
    @user_lists = current_user.lists.uniq.sort_by {|list| list.name}
    erb :'lists/index'
  end

  get '/lists/new' do
    if logged_in?
      @user = current_user
      ert :'lists/create'
    else
      redirect to '/users/login'
    end
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
