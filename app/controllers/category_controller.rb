class CategoryController < ApplicationController

  get '/categories' do
    if logged_in?
      @user = current_user
      @user_categories = current_user.categories.uniq
      erb :'categories/index'
    else
      redirect to '/users/login'
    end
  end

  get '/categories/:id' do
    @category = Category.find_by(id: params[:id])
    @user_items = current_user.items
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

  post '/categories/:id/edit' do
    category = Category.find_by(id: params[:id])
    if !category.admin_lock
      category.name = params[:name]
      category.save
      redirect to "/categories/#{category.id}"
    else
      redirect to '/categories'
    end
  end

end
