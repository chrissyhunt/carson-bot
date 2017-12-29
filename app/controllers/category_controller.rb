class CategoryController < ApplicationController

  get '/categories' do
    if logged_in?
      @user_categories = current_user.categories
      erb :'categories/index'
    else
      redirect to '/users/login'
    end
  end

  get '/categories/new' do
    if logged_in?
      @user = current_user
      erb :'categories/create'
    else
      redirect to '/users/login'
    end
  end

  get '/categories/:id' do
    @category = Category.find_by(id: params[:id])
    if logged_in? && current_user.categories.include?(@category)
      erb :'categories/show'
    else
      redirect to '/users/login'
    end
  end

  get '/categories/:id/edit' do
    @category = Category.find_by(id: params[:id])
    if logged_in? && current_user.categories.include?(@category)
      erb :'categories/edit'
    else
      redirect to '/users/login'
    end
  end

end
