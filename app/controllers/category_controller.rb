class CategoryController < ApplicationController

  get '/categories' do
    erb :'categories/index'
  end

  get '/categories/new' do
    erb :'categories/create'
  end

  get '/categories/:id' do
    erb :'categories/show'
  end

  get '/categories/:id/edit' do
    erb :'categories/'
  end

end
