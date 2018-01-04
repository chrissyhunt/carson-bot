class CategoryController < ApplicationController

  get '/categories' do
    if !logged_in?
      redirect to '/users/login'
    end

    @user = current_user
    @user_categories = current_user.categories.uniq.sort_by {|category| category.name}
    erb :'categories/index'
  end

  get '/categories/:id' do
    if !logged_in?
      redirect to '/users/login'
    end

    @category = Category.find_by(id: params[:id])
    @user_items = current_user.items

    if current_user.categories.include?(@category)
      erb :'categories/show'
    else
      redirect to '/categories'
    end
  end

  get '/categories/:id/edit' do
    if !logged_in?
      redirect to '/users/login'
    end

    @category = Category.find_by(id: params[:id])

    if current_user.categories.include?(@category)
      erb :'categories/edit'
    else
      redirect to '/categories'
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
